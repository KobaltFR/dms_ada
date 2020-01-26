with Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;
use Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;

package P_DMS is

    --function pathToNode(path : IN String) return Node;
    function createDMS return NodePtr;
    procedure init(rootPtr : IN OUT NodePtr);
    procedure pwd(ptr : IN NodePtr);
    function touch(path : IN String) return NodePtr;
    procedure vim(path : IN OUT String);
    function mkdir(path : IN String) return NodePtr;
    procedure cd(path : IN String);
    procedure ls(path : IN String);
    

end P_DMS;
