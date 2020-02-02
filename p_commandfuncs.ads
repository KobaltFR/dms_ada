with Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree, p_gen_doublelinkedlist;
use Ada.Strings.Unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;

package p_commandfuncs is

   -- Name: split_command
   -- Semantics: splits an Unbounded_String based on a given splitter, the output is a Double Linked List of Unbounded_Strings
   -- Parameters:
   --      • splitter : The character that is used to split the Unbounded_String
   --      • command : The Unbounded_String that will be splitted
   -- Return type: Double Linked List of Unbounded_Strings
   -- Preconditions: /
   -- Postconditions: /
   -- Example : splitter = '/', command = "home/Documents/Kobalt" ==> output = ["home", "Documents", "Kobalt"]
   function split_command (splitter : in Character; command : in Unbounded_String) return US_DLL.DoubleLinkedList_Pointer;

   -- Name: interpreter
   -- Semantics: execute the correct command based on the current directory and a Double Linked List of Unbounded_Strings containing the name of the command and its arguments
   -- Parameters:
   --      • argsList : a Double Linked List of Unbounded_Strings containing the name of the command and its arguments (e.g. ["mkdir", "/toto/tata"])
   --      • current_directory : The current directory of your DMS
   -- Return type: /
   -- Preconditions: argsList is not empty, current directory is not null
   -- Postconditions: /
   procedure interpreter (argsList : in US_DLL.DoubleLinkedList_Pointer; current_directory : in out Tree_Node_Pointer);

end p_commandfuncs;
