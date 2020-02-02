with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree, p_dms;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree, p_dms;

package body p_commandfuncs is

   function split_command
     (splitter : in Character; command : in Unbounded_String)
      return US_DLL.DoubleLinkedList_Pointer
   is
      argument       : Unbounded_String;
      lcmd           : Integer;
      low            : Integer := 0;
      high           : Integer := 0;
      args_list      : US_DLL.DoubleLinkedList_Pointer;
      splitter_found : Boolean := False;
   begin
      lcmd := Length (command);
      for i in 1 .. lcmd loop
         if Element (command, i) = splitter or
           (splitter_found and then i = lcmd)
         then
            splitter_found := True;
            if high = 0 then
               high := i;
            elsif i = lcmd then
               low  := high;
               high := lcmd + 1;
            else
               low  := high;
               high := i;
            end if;
            Unbounded_Slice (command, argument, low + 1, high - 1);
            US_DLL.insert_at_end (argument, args_list);
         elsif not splitter_found and then i = lcmd then
            US_DLL.insert_at_end (command, args_list);
         end if;
      end loop;
      return args_list;
   end split_command;

   procedure interpret_command (argsList : in US_DLL.DoubleLinkedList_Pointer; current_directory : in out Tree_Node_Pointer) is
      cmd, path, size, option : Unbounded_String;
      nat_size, list_size : Natural;
   begin
      cmd := US_DLL.get_value (argsList);
      list_size := US_DLL.length(argsList);
      if cmd = To_Unbounded_String ("cd") then
         if list_size > 1 then
            path := US_DLL.get_value (US_DLL.get_next (argsList));
         end if;
         begin
            cd (path, current_directory);
         exception
            when NOT_FOLDER_ELEMENT => Put_Line("You cannot use 'cd' on a file !");
            when INEXISTANT_ELEMENT => Put_Line("You cannot use 'cd' on an inexistant directory !");
         end;
      elsif cmd = To_Unbounded_String ("touch") then
         if list_size > 1 then
            path := US_DLL.get_value (US_DLL.get_next (argsList));
         end if;
         begin
            touch (path, current_directory);
         exception
            when MISSING_ARGUMENTS => Put_Line("'touch': missing argument");
            when NOT_UNIQUE_ELEMENT => Put_Line("The file you want to create already exists !");
            when NOT_FOLDER_ELEMENT => Put_Line("The path specified contains a file instead of a directory (or more)");
            when INEXISTANT_ELEMENT => Put_Line("The path specified contains an inexistant directory (or more)");
         end;
      elsif cmd = To_Unbounded_String ("vim") then
         if list_size > 2 then
            path := US_DLL.get_value (US_DLL.get_next (US_DLL.get_next (argsList)));
            size := US_DLL.get_value (US_DLL.get_next (argsList));
            nat_size := Natural'Value(To_String(size));
         end if;
         begin
            vim (path, nat_size, current_directory);
         exception
            when MISSING_ARGUMENTS => Put_Line("'vim': missing argument");
            when MISSING_NODE => Put_Line("The file you want to modify does not exist !");
            when ELEMENT_NOT_FILE => Put_Line("'vim' only works on files !");
            when NOT_FOLDER_ELEMENT => Put_Line("The path specified contains a file instead of a directory (or more)");
            when INEXISTANT_ELEMENT => Put_Line("The path specified contains an inexistant directory (or more)");
         end;
      elsif cmd = To_Unbounded_String ("mkdir") then
         if list_size > 1 then
            path := US_DLL.get_value (US_DLL.get_next (argsList));
         end if;
         begin
            mkdir (path, current_directory);
         exception
            when MISSING_ARGUMENTS => Put_Line("'mkdir': missing argument");
            when NOT_UNIQUE_ELEMENT => Put_Line("The directory you want to create already exists !");
            when NOT_FOLDER_ELEMENT => Put_Line("The path specified contains a file instead of a directory (or more)");
            when INEXISTANT_ELEMENT => Put_Line("The path specified contains an inexistant directory (or more)");
         end;
      elsif cmd = To_Unbounded_String ("ls") then
         if list_size = 1 then
            ls (current_directory);
         elsif list_size = 2 then
            path := US_DLL.get_value (US_DLL.get_next (argsList));
            if Element(path, 1) = '-' then
               begin
                  ls (current_directory, To_Unbounded_String(""), path);
               exception
                  when UNKNOWN_OPTION => Put_Line("This option is not supported by 'ls' !");
               end;
            else
               begin
                  ls (current_directory, path);
               exception
                  when NOT_FOLDER_ELEMENT => Put_Line("The path specified contains a file instead of a directory (or more)");
                  when INEXISTANT_ELEMENT => Put_Line("The path specified contains an inexistant directory (or more)");
               end;
            end if;
         else
            option := US_DLL.get_value (US_DLL.get_next (argsList));
            path := US_DLL.get_value (US_DLL.get_next (US_DLL.get_next (argsList)));
            begin
               ls (current_directory, path, option);
            exception
               when UNKNOWN_OPTION => Put_Line("This option is not supported by 'ls' !");
               when NOT_FOLDER_ELEMENT => Put_Line("The path specified contains a file instead of a directory (or more)");
               when INEXISTANT_ELEMENT => Put_Line("The path specified contains an inexistant directory (or more)");
            end;
         end if;
      elsif cmd = To_Unbounded_String("pwd") then
         pwd (current_directory);
      elsif cmd /= To_Unbounded_String("exit") then
         Put_Line("Unrecognized command, please enter a valid command...");
      end if;
   end interpret_command;

end p_commandfuncs;
