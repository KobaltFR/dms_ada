with Ada.Strings.unbounded, p_datastruct_tree;
use Ada.Strings.unbounded, p_datastruct_tree;

package P_DMS is

    function createDMS return Tree_Node_Pointer;
    procedure init(tree_root : IN OUT Tree_Node_Pointer);
    procedure pwd(current_directory : IN Tree_Node_Pointer);
    function touch(path : IN Unbounded_String) return Tree_Node_Pointer;
    procedure vim(path : IN OUT Unbounded_String);
    function mkdir(path : IN Unbounded_String) return Tree_Node_Pointer;
    procedure cd(path : IN Unbounded_String);
    procedure ls(path : IN Unbounded_String);
    

end P_DMS;
