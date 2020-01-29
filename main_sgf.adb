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
       choice : Positive;
   begin
       Put_Line("What do you want to do ? (Please enter the number of the command)");
       Put_Line("1. cd : change directory");
       Put_Line("2. pwd : print working directory");
       Put_Line("3. ls (-r) : list files and directories (-r : recursively)");
       Put_Line("4. touch : create file");
       Put_Line("5. mkdir : create directory");
       Get(choice);
       if (choice = 1) then
           null; -- cd
       elsif (choice = 2) then
           null;-- pwd
       elsif (choice = 3) then
           null;-- ls
       elsif (choice = 4) then
           null;-- touch
       elsif (choice = 5) then
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
