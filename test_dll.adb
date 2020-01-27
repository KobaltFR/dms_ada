with Ada.Text_IO, Ada.Strings.Unbounded, p_gen_doublelinkedlist;
use Ada.Text_IO, Ada.Strings.Unbounded;

procedure test_dll is

   package US_DLL is new p_gen_doublelinkedlist(T_Value => Unbounded_String, "=" => "=", image => To_String);
   use US_DLL;

   list : US_DLL.DoubleLinkedList_Pointer;

begin

   US_DLL.insert_at_start(To_Unbounded_String("a"), list);

   if is_unique(To_Unbounded_String("a"), list) then
      Put_Line("Unique");
   else
      Put_Line("Not Unique");
   end if;

end test_dll;
