#include "rice/Class.hpp"
#include "rice/Data_Type.hpp"
#include "rice/Constructor.hpp"
#include "Brofficiency.h"

using namespace Rice;

extern "C"
void Init_bro_rice()
{
    define_class<Bro>("Bro").
      define_constructor(Constructor<Bro>()).
      define_method("Brofficiency", &Bro::Brofficiency);
      define_method("makeUserVector", &Bro::makeUserVector);
}

