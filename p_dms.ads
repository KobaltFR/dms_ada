with Ada.Strings.Unbounded, p_datastruct_tree;
use Ada.Strings.Unbounded, p_datastruct_tree;

package p_dms is

   MISSING_ARGUMENTS : exception;
   MISSING_NODE : exception;
   ELEMENT_NOT_FILE : exception;
   UNKNOWN_OPTION : exception;

   --Creates the root node of the tree
   function createDMS return Tree_Node_Pointer;

   --Initalizes a tree with a few nodes, used for testing
   procedure init (tree_root : in out Tree_Node_Pointer);

   --Displays on the screen each values of 'path_dll' with '/' between them
   --Example : path_dll = ["/", "home", "Documents"] ==> output = "/home/Documents"
   procedure display_path (path_dll : in US_DLL.DoubleLinkedList_Pointer);

   -- Name: pwd
   -- Semantics: Displays on the screen the absolute path of the current directory
   -- Parameters:
   --      • current_directory : The directory that is currently pointed at
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : /
   procedure pwd (current_directory : in Tree_Node_Pointer);

   -- Name: touch
   -- Semantics: Creates a new file, from the input path (last name is your file name) and the current_directory
   -- Parameters:
   --       • path : The path used to create the file
   --       • current_directory : The directory that is currently pointed at
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : MISSING_ARGUMENTS = raised if the path is empty
   procedure touch (path : in Unbounded_String; current_directory : in Tree_Node_Pointer);

   -- Name: vim
   -- Semantics: Changes the size on the disk used by the file
   -- Parameters:
   --       • path : The path leading to the file
   --       • new_size : The value of the new size on the disk
   --       • current_directory : The directory that is currently pointed at
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : MISSING_ARGUMENTS = raised if the path is empty
   --              MISSING_NODE = raised if the file does not exist
   --              ELEMENT_NOT_FILE = raised if the path points to a directory
   procedure vim (path : in Unbounded_String; new_size : in Natural; current_directory : in Tree_Node_Pointer);

   -- Name: mkdir
   -- Semantics: Creates a new directory, from the input path (last name is your file name) and the current_directory
   -- Parameters:
   --       • path : The path used to create the directory
   --       • current_directory : The directory that is currently pointed at
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : MISSING_ARGUMENTS = raised if the path is empty
   procedure mkdir (path : in Unbounded_String; current_directory : in Tree_Node_Pointer);

   -- Name: cd
   -- Semantics: Changes directory based on the given path
   -- Parameters:
   --       • path : The path used to change directory
   --       • current_directory : The directory that is currently pointed at
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : /
   procedure cd (path : in Unbounded_String; current_directory : in out Tree_Node_Pointer);

   -- Same as cd but doesn't use the last element of the path (changes to the second to last directory of the path), 'name' is the name of the element of the path
   procedure cd_parent (path : in Unbounded_String; name : out Unbounded_String; current_directory : in out Tree_Node_Pointer);

   -- Name: ls
   -- Semantics: Lists the children of the current directory (or the directory pointed by the path), using the input options (-r or -l)
   -- Parameters:
   --       • current_directory : The directory that is currently pointed at
   --       • path : The path to a given directory
   --       • path : One of the options of ls
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   -- Exceptions : UNKNOWN_OPTION : raised when an option that isn't '-r' or '-l' is used
   procedure ls (current_directory : in Tree_Node_Pointer; path : in Unbounded_String := To_Unbounded_String (""); option : in Unbounded_String := To_Unbounded_String (""));

end p_dms;
