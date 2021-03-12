#include <iostream>
#include <stack>
using namespace std;


struct Node {
    string exp = "";
    Node* left = 0;
    Node* right = 0;
};

Node* createNode(string exp) {
    Node* newNode = new Node;
    newNode->exp = exp; 
    return newNode;
}

Node* appendNodeLeft(Node* parent, string exp) {
    parent->left = createNode(exp);
    return parent;
}

Node* appendNodeRight(Node* parent, string exp) {
    parent->right = createNode(exp);
    return parent;
}

Node* getAnalyzeTree(string exp) {
    
    return 0;
}



int main() {
    string exp = "a+(b-c)";



    return 0;
}