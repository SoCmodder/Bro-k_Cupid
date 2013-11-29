
#ifndef QANDA_H
#define QANDA_H

class QandA
{
  public:
    int questionID;
    int answer;
    int importance;
    bool operator < (const QandA rhs) const { return (questionID < rhs.questionID) ? true : false; }
};


#endif