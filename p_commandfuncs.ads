with Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree, p_gen_doublelinkedlist;
use Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;

package p_commandfuncs is

   function split_command
     (splitter : in Character; command : in Unbounded_String)
      return US_DLL.DoubleLinkedList_Pointer;

   procedure interpret_command (argsList : in US_DLL.DoubleLinkedList_Pointer; current_directory : in out Tree_Node_Pointer);

end p_commandfuncs;
