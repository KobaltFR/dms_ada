with Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO, p_gen_doublelinkedlist;
use Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO;

package p_commandfuncs is

   package US_DLL is new p_gen_doublelinkedlist(T_Value => Unbounded_String, "=" => "=", image => To_String);
   use US_DLL;

   function split_command(splitter : IN Character; command : IN unbounded_string) return DoubleLinkedList_Pointer;

end p_commandfuncs;
