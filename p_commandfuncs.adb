with Ada.Text_IO,Ada.Integer_Text_IO,Ada.Float_Text_IO,Ada.Strings.unbounded,Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO,Ada.Integer_Text_IO,Ada.Float_Text_IO,Ada.Strings.unbounded,Ada.Text_IO.Unbounded_IO;

package body p_commandfuncs is

   function split_command(splitter : IN Character; command : IN unbounded_string) return DoubleLinkedList_Pointer is
      argument : Unbounded_String;
      lcmd : Integer;
      low : Integer := 0;
      high : Integer := 0;
      args_list : DoubleLinkedList_Pointer;
      splitter_found : Boolean := False;
   begin
      lcmd := Length(command);
      for i in 1..lcmd loop
         if Element(command, i) = splitter or (splitter_found and then i = lcmd) then
            splitter_found := True;
            if high = 0 then
               high := i;
            elsif i = lcmd then
               low := high;
               high := lcmd+1;
            else
               low := high;
               high := i;
            end if;
            Unbounded_Slice(command, argument, low+1, high-1);
            insert_at_end(argument, args_list);
         elsif not splitter_found and then i = lcmd then
            insert_at_end(command, args_list);
         end if;
      end loop;
      return args_list;
   end split_command;

   procedure interpretCommand(argsList : IN DoubleLinkedList_Pointer) is
      cmd : Unbounded_String;
   begin
      cmd := get_value(argsList);
      if cmd = To_Unbounded_String("cd") then
          null;--cd(cmdTab(2));
      elsif cmd = To_Unbounded_String("touch") then
          null;--touch(cmdTab(2));
      elsif cmd = To_Unbounded_String("vim") then
          null;--vim(cmdTab(2));
      elsif cmd = To_Unbounded_String("mkdir") then
          null;--mkdir(cmdTab(2));
      elsif cmd = To_Unbounded_String("ls") then
          null;--ls(cmdTab(2));
      end if;
   end interpretCommand;

end p_commandfuncs;
