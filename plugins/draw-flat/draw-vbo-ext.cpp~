#include "draw-vbo-ext.h"
#include "glwidget.h"
#include <cmath>

// A Cluster represents a collection of corners sharing a normal vector
class Cluster
{
public:
    vector<int> faces;
    Vector normal;
    int index;   // index in the final VBO
};

void DrawVBO::cleanUp()
{
	glDeleteBuffers(coordBuffers.size(),  &coordBuffers[0]);
	glDeleteBuffers(normalBuffers.size(), &normalBuffers[0]);
    glDeleteBuffers(indexBuffers.size(),  &indexBuffers[0]);
    glDeleteBuffers(stBuffers.size(),  &stBuffers[0]);
    glDeleteBuffers(colorBuffers.size(),  &colorBuffers[0]);

    glDeleteVertexArrays(VAOs.size(), &VAOs[0]);
    
    coordBuffers.clear();
    normalBuffers.clear();
    indexBuffers.clear();
    stBuffers.clear();
    colorBuffers.clear();
    VAOs.clear();

    numIndices.clear(); 
}

DrawVBO::~DrawVBO()
{
    cleanUp();
}

void DrawVBO::onSceneClear()
{
    cleanUp();
}

bool DrawVBO::drawObject(int i)
{
    glBindVertexArray(VAOs[i]);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffers[i]);
	glDrawElements(GL_TRIANGLES, numIndices[i], GL_UNSIGNED_INT, (GLvoid*) 0);

    glBindVertexArray(0);
    glBindBuffer(GL_ARRAY_BUFFER,0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,0);
    return true;
}

bool DrawVBO::drawScene()
{
    //static int counter = 0;
    //cout << "drawScene " << counter++ << endl;
    //glEnable(GL_CULL_FACE);
    //glEnable(GL_DEPTH_TEST);
    
	for(unsigned int i=0; i<coordBuffers.size(); i++) // for each buffer (that is, for each object)
	{
        //cout << "  Object " << i << " with " << numIndices[i] << " indices " << endl;

        glBindVertexArray(VAOs[i]);
	    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffers[i]);

		glDrawElements(GL_TRIANGLES, numIndices[i], GL_UNSIGNED_INT, (GLvoid*) 0);
        //cout << "  End " << endl;

	}

	
    glBindVertexArray(0);

    glBindBuffer(GL_ARRAY_BUFFER,0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,0);

    return true;
}

void DrawVBO::onPluginLoad()
{
    for(unsigned int i=0; i<scene()->objects().size(); i++)
        addVBO(i);
}

void DrawVBO::onObjectAdd()
{
    addVBO( scene()->objects().size() - 1 );
}

void DrawVBO::buildVF(const Object& obj, vector<vector<int> >& VF)
{
    // build V:{F} relationship
    VF.clear();
    VF.resize(obj.vertices().size());
    for(unsigned int j=0; j<obj.faces().size(); j++)  // for each face
	{
        const Face& face = obj.faces()[j];
	    //Vector N = face.normal();
		for(unsigned int k=0; k<(unsigned int)face.numVertices(); k++) // for each vertex
		{
			VF[face.vertexIndex(k)].push_back(j); 
		}
	}
}

int findCluster(const Object& obj, int face, vector<Cluster>& clusters)
{
    const float MAX_ANGLE = 80; // degrees
    const float MIN_COS = cos(MAX_ANGLE/180*3.14);
    unsigned int i;
    for (i=0; i<clusters.size(); ++i)
    {
        Vector n1 = clusters[i].normal.normalized();
        Vector n2 = obj.faces()[face].normal().normalized();
        float c = Vector::dotProduct(n1,n2);
        if (c > MIN_COS) return i;
    }
    return -1;
}

void cluster(const Object& obj, vector<vector<int> >& VF, vector<vector<Cluster> >& clusters)
{
    clusters.clear();
    clusters.resize(VF.size());
    // group vertices in V:{F} into clusters, according to per-face normals
    for (unsigned int i=0; i<VF.size(); ++i) // for each vertex 
    {
        vector<int>& faces = VF[i]; 
        // assign first face to cluster 0
        Cluster cluster; 
        int f = faces[0];
        cluster.faces.push_back(f); 
        cluster.normal = obj.faces()[f].normal();
        clusters[i].push_back(cluster);
        // for each remaining face in V:{F}, try to add to an existing cluster or create new cluster
        for (unsigned int j=1; j<faces.size(); ++j)
        {
            f = faces[j];
            int index = findCluster(obj, f, clusters[i]); 
            if (index>=0) // add to an existing cluster
            {
                clusters[i][index].faces.push_back(f); 
                clusters[i][index].normal +=  obj.faces()[f].normal();           
            }
            else    // add to new cluster
            {
                Cluster cluster; 
                cluster.faces.push_back(f); 
                cluster.normal = obj.faces()[f].normal();
                clusters[i].push_back(cluster);
            }
        }
    }
}

int findIndexInCluster(vector<Cluster>& clusters, int face)
{
    for (unsigned int i=0; i<clusters.size(); ++i)
    {
        Cluster& cluster = clusters[i];
        for (unsigned int j=0; j<cluster.faces.size(); ++j)
        {
            if (cluster.faces[j]==face) return cluster.index;
        }
    }
    cout << "ERROR in VBO" << endl;
    return -1;
}

void DrawVBO::addVBO(unsigned int currentObject)
{  
    // Step 1: Create and fill the four arrays (vertex coords, vertex normals, and face indices) 
    // This version: 
    //  - each coord/normal will appear n times (one for each corner with unique normal)
    //  - non-triangular faces (convexity is assumed) are triangulated on-the-fly: (v0,v1,v2,v3) -> (v0,v1,v2) (v0,v2,v3)
    vector<float> vertices; // (x,y,z)    Final size: 3*number of corners
    vector<float> normals;  // (nx,ny,nz) Final size: 3*number of corners
    vector<float> st;       // (s,t)      Final size: 2*number of corners  
    vector<float> colors;   // (r,g,b)    Final size: 3*number of corners
	vector<int> indices;    //            Final size: 3*number of triangles  

    //unsigned int indexCount = 0; 
	
    const Object& obj = scene()->objects()[currentObject];
    vector<vector<int> > VF;
    buildVF(obj, VF); // V:{F} incidence relationship
    vector<vector<Cluster> > clusters;
    cluster(obj, VF, clusters); // clusters[i] contains the clusters for vertex i.

    // Fill the arrays (vertex coords, vertex normals, st)
    int vertexIndex = 0; 
    for (unsigned int j=0; j<clusters.size(); ++j)   // for each vertex
    {
        vector<Cluster>& cl = clusters[j]; 
        for (unsigned int k=0; k<cl.size(); ++k)  // for each cluster
        {
            Cluster& cluster = cl[k];
            Point P = obj.vertices()[j].coord();
			vertices.push_back(P.x()); vertices.push_back(P.y()); vertices.push_back(P.z());
            Vector N = cluster.normal.normalized();
			normals.push_back(N.x()); normals.push_back(N.y()); normals.push_back(N.z());
            float r = obj.boundingBox().radius();
            //float rx = obj.boundingBox().max().x() - obj.boundingBox().min().x();
            //float ry = obj.boundingBox().max().y() - obj.boundingBox().min().y();
            float s = Vector::dotProduct((1.0/r)*Vector(1, 0, 1), P);
            float t = Vector::dotProduct((1.0/r)*Vector(0, 1, 0), P);
            if (obj.vertices().size() == 81) // plane: special case for /assig models
            {
                //cout << "PLane" << endl;
                s = 0.5f*(P.x() + 1.0);
                t = 0.5f*(P.y() + 1.0);
            }
            if (obj.vertices().size() == 386) // cube: special case for /assig models
            {
                //cout << "Cube" << endl;
                s = Vector::dotProduct((1.0/2.0)*Vector(1, 0, 1), P);
                t = Vector::dotProduct((1.0/2.0)*Vector(0, 1, 0), P);
            }
            st.push_back(s);
            st.push_back(t);
            colors.push_back(abs(N.x()));
            colors.push_back(abs(N.y()));
            colors.push_back(abs(N.z()));
            cluster.index = vertexIndex++;

        }    
    }

    // Fill array of indices
	for(unsigned int j=0; j<obj.faces().size(); j++)  // for each face
	{
        const Face& face = obj.faces()[j];
		for(unsigned int k=1; k<(unsigned int)face.numVertices()-1; k++) // for each triangle
		{
            // first vertex 
            int v0 = face.vertexIndex(0);
            int index = findIndexInCluster(clusters[v0], j);
            indices.push_back(index);

            // second vertex 
			int v1 = face.vertexIndex(k);
            index = findIndexInCluster(clusters[v1], j);
            indices.push_back(index);

            // third vertex 
            int v2 = face.vertexIndex(k+1);
            index = findIndexInCluster(clusters[v2], j);
            indices.push_back(index);
		}
	}

    // Step 2: Create empty buffers (coords, normals, st, indices)
    GLuint VAO;
    glGenVertexArrays(1, &VAO);
    VAOs.push_back(VAO);
    glBindVertexArray(VAO);

    GLuint coordBufferID;
	glGenBuffers(1, &coordBufferID);
    coordBuffers.push_back(coordBufferID);

    GLuint normalBufferID;
	glGenBuffers(1, &normalBufferID);
    normalBuffers.push_back(normalBufferID);

    GLuint colorBufferID;
	glGenBuffers(1, &colorBufferID);
    colorBuffers.push_back(colorBufferID);

    GLuint stBufferID;
	glGenBuffers(1, &stBufferID);
    stBuffers.push_back(stBufferID);

    GLuint indexBufferID;
	glGenBuffers(1, &indexBufferID);
    indexBuffers.push_back(indexBufferID);

	numIndices.push_back(indices.size());

    // Step 3: Define VBO data (coords, normals, indices)
	glBindBuffer(GL_ARRAY_BUFFER, coordBuffers[currentObject]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(float)*vertices.size(), &vertices[0], GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);  // VAO
    glEnableVertexAttribArray(0);

	glBindBuffer(GL_ARRAY_BUFFER, normalBuffers[currentObject]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(float)*normals.size(), &normals[0], GL_STATIC_DRAW);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 0, 0);  // VAO
    glEnableVertexAttribArray(1);

	glBindBuffer(GL_ARRAY_BUFFER, colorBuffers[currentObject]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(float)*colors.size(), &colors[0], GL_STATIC_DRAW);
    glVertexAttribPointer(2, 3, GL_FLOAT, GL_FALSE, 0, 0);  // VAO
    glEnableVertexAttribArray(2);

	glBindBuffer(GL_ARRAY_BUFFER, stBuffers[currentObject]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(float)*st.size(), &st[0], GL_STATIC_DRAW);
    glVertexAttribPointer(3, 2, GL_FLOAT, GL_FALSE, 0, 0);  // VAO
    glEnableVertexAttribArray(3);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffers[currentObject]);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(int)*indices.size(), &indices[0], GL_STATIC_DRAW);

    glBindVertexArray(0);
    glBindBuffer(GL_ARRAY_BUFFER,0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER,0);

}

#if QT_VERSION < 0x050000
    Q_EXPORT_PLUGIN2(draw-vbo-ext, DrawVBO)   // plugin name, plugin class
#endif



