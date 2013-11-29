#include "Brofficiency.h"

int Bro::Brofficiency(std::string User1, std::string User2)
{
  std::vector<QandA> user1, user2;
  float total1 = 0.0, comparedTotal1 = 0.0, total2 = 0.0, comparedTotal2 = 0.0;
  int iterator1 = 0, iterator2 = 0;
  int weights[6];
  
  weights[1] = 0;
  weights[2] = 1;
  weights[3] = 10;
  weights[4] = 50;
  weights[5] = 100;
  
  makeUserVector(user1, User1);
  makeUserVector(user2, User2);
  
  std::sort(user1.begin(), user1.end());
  std::sort(user2.begin(), user2.end());
  
  while(iterator1 < user1.size() && iterator2 < user2.size())
  {
    if(user1[iterator1].questionID == user2[iterator2].questionID)
    {
      int diff = 5 - abs(user1[iterator1].answer - user2[iterator2].answer);
      comparedTotal1 += diff * weights[user1[iterator1].importance];
      comparedTotal2 += diff * weights[user2[iterator2].importance];
      total1 += 5 * weights[user1[iterator1].importance];
      total2 += 5 * weights[user2[iterator2].importance];
      iterator1++;
      iterator2++;
    }
    else if(user1[iterator1].questionID < user2[iterator2].questionID)
    {
      iterator1++;
    }
    else if(user1[iterator1].questionID > user2[iterator2].questionID)
    {
      iterator2++;
    }
  }
  
  if(total1 == 0 || total2 == 0)
  {
    return 0;
  }
  else
  {
    return std::sqrt((comparedTotal1 / total1) * (comparedTotal2 / total2)) * 100;
  }
}

void Bro::makeUserVector(std::vector<QandA>& User, std::string rawUser)
{
  QandA temp;
  std::istringstream iss(rawUser);
  std::string sub;
  
  while(iss >> sub)
  {
    temp.questionID = std::atoi(sub.c_str());
    iss >> sub;
    temp.answer = std::atoi(sub.c_str());
    iss >> sub;
    temp.importance = std::atoi(sub.c_str());
    User.push_back(temp);
  }
}