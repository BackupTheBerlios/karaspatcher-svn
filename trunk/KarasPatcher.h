// generated by Fast Light User Interface Designer (fluid) version 2.1000

#ifndef KarasPatcher_h
#define KarasPatcher_h
#include <windows.h>
#include <Winuser.h>
extern const char *newprojectfilename;
extern const char *openprojectfilename;
extern char filename[MAX_PATH];
#include <fltk/Window.h>
#define IDI_ICON2 1
#include <fltk/Monitor.h>
#include <fltk/win32.h>
#include <fltk/run.h>
extern fltk::Window* Window;
#include <fltk/MenuBar.h>
#include <fltk/ItemGroup.h>
#include <fltk/Item.h>
#include <fltk/file_chooser.h>
extern fltk::Item* MenuNewProject;
extern fltk::Item* MenuOpenProject;
#include <fltk/Divider.h>
extern fltk::Item* MenuExit;
extern fltk::Item* about;
#include <fltk/Group.h>
extern fltk::Group* infotab;
#include <fltk/Input.h>
extern fltk::Input* teamin;
extern fltk::Input* teamwebsitein;
#include <fltk/TextEditor.h>
#include <fltk/LightButton.h>
extern fltk::LightButton* teamornoteam;
extern fltk::LightButton* webnoweb;
#include <fltk/Button.h>
extern fltk::Button* nextbutton;
extern fltk::Button* previousbutton;
extern fltk::Button* boutonexit;
fltk::Window* main_window();
#include <fltk/DoubleBufferWindow.h>
extern fltk::DoubleBufferWindow* aboutuswindow;
#include <fltk/ReturnButton.h>
extern fltk::ReturnButton* aboutusokbutton;
fltk::DoubleBufferWindow* about_window();
#endif
