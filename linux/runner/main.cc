#include "my_application.h"

int main(int argc, char** argv) {
  SetEnvironmentVariable(L"FLUTTER_TARGET", L"lib/linux_main.dart");

  g_autoptr(MyApplication) app = my_application_new();
  return g_application_run(G_APPLICATION(app), argc, argv);
}
