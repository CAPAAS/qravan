#include "qravan.h"

VALUE rb_mQravan;

void
Init_qravan(void)
{
  rb_mQravan = rb_define_module("Qravan");
}
