#ifndef BROFFICIENCY_H
#define BROFFICIENCY_H

#include<vector>
#include "QandA.h"
#include<iostream>
#include<string>
#include<sstream>
#include<cstdlib>
#include<cmath>
#include<algorithm>

class Bro
{
  public:
    Bro(){}
    int Brofficiency(std::string User1, std::string User2);
    
  private:
    void makeUserVector(std::vector<QandA>& User, std::string rawUser);
};


#endif