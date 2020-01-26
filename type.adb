package P_DMS is

    type Node;
    NodePtr is access of Node;

    type Node is record
        name : String(1..30);
        rights : String(1..4);
        size : Integer;
        parentFolder : NodePtr;
        child : NodePtr;
        next : NodePtr;
    end record;

    --function pathToNode(path : IN String) return Node;
    function createDMS() return Node;
    procedure init(root : IN OUT Node);
    procedure pwd(ptr : IN NodePtr);
    function touch(path : IN String) return Node;
    procedure vim(path : IN OUT String);
    function mkdir(path : IN String) return Node;
    procedure cd(path : IN String);
    procedure ls(path : IN String);
    

end P_DMS;