with Ada.Strings.Unbounded, p_datastruct_tree;
use Ada.Strings.Unbounded, p_datastruct_tree;

package p_dms is

   MISSING_ARGUMENTS : exception;
   MISSING_NODE : exception;
   ELEMENT_NOT_FILE : exception;
   UNKNOWN_OPTION : exception;

   function createDMS return Tree_Node_Pointer;
   procedure init (tree_root : in out Tree_Node_Pointer);
   procedure display_path (path_dll : in US_DLL.DoubleLinkedList_Pointer);
   procedure pwd (current_directory : in Tree_Node_Pointer);
   procedure touch
     (path : in Unbounded_String; current_directory : in Tree_Node_Pointer);
   procedure vim
     (path : in Unbounded_String; new_size : in Natural; current_directory : in Tree_Node_Pointer);
   procedure mkdir
     (path : in Unbounded_String; current_directory : in Tree_Node_Pointer);
   procedure cd
     (path              : in Unbounded_String;
      current_directory : in out Tree_Node_Pointer);
   procedure cd_parent
     (path : in Unbounded_String; name : out Unbounded_String; current_directory : in out Tree_Node_Pointer);
   procedure ls
     (current_directory : in Tree_Node_Pointer;
      path              : in Unbounded_String := To_Unbounded_String ("");
      option            : in Unbounded_String := To_Unbounded_String (""));

end p_dms;
