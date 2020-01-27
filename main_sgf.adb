with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

with Ada.Float_Text_IO;
use Ada.Float_Text_IO;

with Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO;
use Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO;

with p_commandfuncs;
use p_commandfuncs;

procedure main_sgf is
   
   procedure commandMenu is
       choice : unbounded_string;
   begin
       Put_Line("What do you want to do ? (Please enter the number of the command)");
       Put_Line("1. cd : change directory");
       Put_Line("2. pwd : print working directory");
       Put_Line("3. ls : list files and directories");
       Put_Line("4. touch : create file");
       Put_Line("5. mkdir : create directory");
       choice := To_Unbounded_String(Get_Line);
       if (To_String(choice) = "cd") then
           null; -- cd
       elsif (To_String(choice) = "pwd") then
           null;-- pwd
       elsif (To_String(choice) = "ls") then
           null;-- ls
       elsif (To_String(choice) = "touch") then
           null;-- touch
       elsif (To_String(choice) = "mkdir") then
           null;-- mk
       end if;
   end commandMenu;

   procedure commandPrompt is
       command : Unbounded_String;
       argsList : US_DLL.DoubleLinkedList_Pointer;
   begin
       loop
         Put("> ");
         command := To_Unbounded_String(Get_Line);
         argsList := split_command(' ', command);
         US_DLL.display(argsList);
         Put("Length : ");
         Put(US_DLL.length(argsList), width => 2);
         New_Line;
         exit when To_String(command) = "exit";
       end loop;
   end commandPrompt;

   procedure mainMenu is
       choice : unbounded_string;
       length : Integer := 1;
   begin
       Put_Line("What do you want to do ? (Enter 'exit' to stop)");
       Put_Line("(P)rompt command");
       Put_Line("(M)enu");
       New_Line;
       choice := To_Unbounded_String(Get_Line);
       if (To_String(choice) = "M") then  
           commandMenu;
       elsif (To_String(choice) = "P") then
           commandPrompt;
       end if;
   end mainMenu;

begin

   mainMenu;

end main_sgf;
