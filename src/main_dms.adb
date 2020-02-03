with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO;

with p_commandfuncs, p_dms, p_datastruct_tree;
use p_commandfuncs, p_dms, p_datastruct_tree;

procedure main_dms is

   procedure command_prompt is
      file_system : Tree_Node_Pointer;
      command  : Unbounded_String;
      argsList : US_DLL.DoubleLinkedList_Pointer;
   begin
      file_system := createDMS;
      loop
         Put ("[" & To_String(get_node_name(file_system)) & "] > ");
         command  := To_Unbounded_String (Get_Line);
         argsList := split_command (' ', command);
         interpreter(argsList, file_system);
         exit when To_String (command) = "exit";
      end loop;
   end command_prompt;

   procedure command_menu is
      --choice : Positive;
   begin
      --Put_Line ("What do you want to do ? (Please enter the number of the command)");
      --Put_Line ("1. cd : change directory");
      --Put_Line ("2. pwd : print working directory");
      --Put_Line ("3. ls (-r / -l) : list files and directories (-r : recursively / -l : more informations)");
      --Put_Line ("4. touch : create file");
      --Put_Line ("5. mkdir : create directory");
      --Get (choice);
      --if (choice = 1) then
      --   null; -- cd
      --elsif (choice = 2) then
      --   null;-- pwd
      --elsif (choice = 3) then
      --   null;-- ls
      --elsif (choice = 4) then
      --   null;-- touch
      --elsif (choice = 5) then
      --   null;-- mk
      --end if;
      Put_Line("The command menu is not available at the moment, you will now be redirected to the command prompt, sorry for the inconvenience...");
      command_prompt;
   end command_menu;

   procedure main_menu is
      choice : Unbounded_String;
      length : Integer := 1;
   begin
      Put_Line ("What do you want to do ? (Enter 'exit' to stop)");
      Put_Line ("(P)rompt command");
      Put_Line ("(M)enu");
      New_Line;
      choice := To_Unbounded_String (Get_Line);
      if (To_String (choice) = "M") then
         command_menu;
      elsif (To_String (choice) = "P") then
         command_prompt;
      end if;
   end main_menu;

begin

   main_menu;

end main_dms;
