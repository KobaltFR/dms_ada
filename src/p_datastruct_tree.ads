with Ada.Strings.Unbounded, p_metadata, p_gen_doublelinkedlist;
use Ada.Strings.Unbounded, p_metadata;

package p_datastruct_tree is

  type Tree_Node is private;
  type Tree_Node_Pointer is access Tree_Node;

    
  function equals (node1 : in Tree_Node_Pointer; node2 : in Tree_Node_Pointer) return Boolean;
  function print (node : in Tree_Node_Pointer) return String;


  package TN_DLL is new p_gen_doublelinkedlist (T_Value => Tree_Node_Pointer, "=" => equals, image => print);
  use TN_DLL;

  package US_DLL is new p_gen_doublelinkedlist (T_Value => Unbounded_String, "=" => "=", image => To_String);
  use US_DLL;


  INEXISTANT_ELEMENT : exception;
  NOT_UNIQUE_ELEMENT : exception;
  NOT_FOLDER_ELEMENT : exception;

  -- Name: get_node_name
  -- Semantics: Returns the name of the tree node
  -- Parameters:
  --      • node : The tree node whose name will be returned
  -- Return type: Unbounded_String
  -- Preconditions: node is not null
  -- Postconditions: /
  function get_node_name (node : in Tree_Node_Pointer) return Unbounded_String;

  -- Name: set_node_name
  -- Semantics: Sets a new name to a given tree node
  -- Parameters:
  --      • name : The name you want to give to the node
  --      • node : The tree node whose name will be changed
  -- Return type: /
  -- Preconditions: node is not null
  -- Postconditions: /
  procedure set_node_name (name : in Unbounded_String; node : in out Tree_Node_Pointer);

  function get_metadata (node : in Tree_Node_Pointer) return Metadata;
  procedure set_metadata (data : in Metadata; node : in out Tree_Node_Pointer);

  function get_parent_node (node : in Tree_Node_Pointer) return Tree_Node_Pointer;
  procedure set_parent_node (pointer : in Tree_Node_Pointer; node : in out Tree_Node_Pointer);
  
  function get_child_node (node : in Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer;
  procedure set_child_node (child_list : in TN_DLL.DoubleLinkedList_Pointer; node : in out Tree_Node_Pointer);
  
  -- Name: set_tree_node
  -- Semantics: Sets a whole new node to a given one
  -- Parameters:
  --      • out_node : The node that will be changed
  --      • in_node : The node that you want to change to
  -- Return type: /
  -- Preconditions: /
  -- Postconditions: /
  procedure set_tree_node (out_node : out Tree_Node_Pointer; in_node : in Tree_Node_Pointer);

  -- Name: get_node_for_alphabetical_insert
  -- Semantics: Returns the node after you want to insert alphabetically to, or null if you need to insert at the start of the list
  -- Parameters:
  --      • name : The name of the node you want to insert alphabetically
  --      • dll : The Double Linked List of Tree Nodes you want to insert in
  -- Return type: A pointer to a cell of a Double Linked List of Tree Nodes
  -- Preconditions: /
  -- Postconditions: /
  function get_node_for_alphabetical_insert (name : in Unbounded_String; dll : in TN_DLL.DoubleLinkedList_Pointer) return TN_DLL.DoubleLinkedList_Pointer;
  
  -- Name: alphabetical_insert
  -- Semantics: Inserts alphabetically a given node into a given Double Linked List of Tree Nodes
  -- Parameters:
  --      • node_to_insert : The node you want to insert alphabetically
  --      • dll : The Double Linked List of Tree Nodes you want to insert in
  -- Return type: /
  -- Preconditions: node_to_insert is not null
  -- Postconditions: /
  procedure alphabetical_insert (node_to_insert : in Tree_Node_Pointer; dll : in out TN_DLL.DoubleLinkedList_Pointer);

  -- Name: init
  -- Semantics: Creates a new pointer to a tree node with the given attributes
  -- Parameters:
  --      • name : The name you want to give to the new Tree Node
  --      • data : The metadata you want to give to the new Tree Node
  --      • parent : The parent node of your new Tree Node
  --      • children : The children list of your new Tree Node
  -- Return type: A pointer to a tree node
  -- Preconditions: /
  -- Postconditions: /
  function init (name : in Unbounded_String; data : in Metadata; parent : in Tree_Node_Pointer; children : in TN_DLL.DoubleLinkedList_Pointer) return Tree_Node_Pointer;
  
  function is_empty (node : in Tree_Node_Pointer) return Boolean;

  -- Name: is_unique
  -- Semantics: Returns if the name is already used in the children list
  -- Parameters:
  --      • name : The name you want to check if its already taken
  --      • children : The children list
  -- Return type: Boolean
  -- Preconditions: /
  -- Postconditions: /
  function is_unique (name : in Unbounded_String; children : in TN_DLL.DoubleLinkedList_Pointer) return Boolean;

  -- Name: find_child
  -- Semantics: If one of the children of the 'current_node' is equals to 'element_name', returns this child
  -- Parameters:
  --      • element_name : The name of the element you want to check if it already used by a child
  --      • children : The children list
  -- Return type: Boolean
  -- Preconditions: /
  -- Postconditions: /
  function find_child (element_name : in Unbounded_String; current_node : in Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer;

  procedure goto_root (current_node : in out Tree_Node_Pointer);

  -- Name: goto_node
  -- Semantics: Goes to the node (if it is a folder) from the current node, using the list of directory names 'path_to_node'
  -- Parameters:
  --      • path_to_node : The list of directory names ot go to the folder node
  --      • current_node : The node that is currently pointed to
  -- Return type: /
  -- Preconditions: /
  -- Postconditions: /
  -- Exceptions : NOT_FOLDER_ELEMENT : raised if one of the nodes pointed at by the path list is not a folder
  --              INEXISTANT_ELEMENT : raised if one of the nodes pointed at by the path list does not exist
  procedure goto_node (path_to_node : in US_DLL.DoubleLinkedList_Pointer; current_node : in out Tree_Node_Pointer);
  
  -- Name: insert
  -- Semantics: Inserts the new node to the tree, based on its list of directory names 'path_to_node', its metadata and the current node
  -- Parameters:
  --      • path_to_node : The list of directory names to go to the folder node (the last element is the name of your new node)
  --      • data : The metadata of your new node
  --      • current_node : The node that is currently pointed to
  -- Return type: /
  -- Preconditions: /
  -- Postconditions: /
  -- Exceptions : NOT_UNIQUE_ELEMENT : raised if the name of the node you want to insert is already used in the children list of the last directory of the path list
  procedure insert (path_to_node : in US_DLL.DoubleLinkedList_Pointer; data : in Metadata; current_node : in Tree_Node_Pointer);
  
  -- Name: delete
  -- Semantics: Deletes the node of the tree, based on its list of directory names 'path_to_node' and the current node
  -- Parameters:
  --      • path_to_node : The list of directory names to go to the folder node (the last element is the name of the node)
  --      • current_node : The node that is currently pointed to
  -- Return type: /
  -- Preconditions: /
  -- Postconditions: /
  -- Exceptions : INEXISTANT_ELEMENT : raised if the node you want to delete does not exist
  procedure delete (path_to_node : in US_DLL.DoubleLinkedList_Pointer; current_node : in Tree_Node_Pointer);
  
  -- Name: display
  -- Semantics: Displays the children list of the current node, recursively or not, in a detailed manner or not
  -- Parameters:
  --      • current_node : The node that is currently pointed to
  --      • recursively : Boolean used to display recursively or not
  --      • detailed : Boolean used to display the details of the child or not
  --      • spaces : The number of spaces used for the indentation
  -- Return type: /
  -- Preconditions: /
  -- Postconditions: /
  procedure display (current_node : in Tree_Node_Pointer; recusively : in Boolean := False; detailed : in Boolean := False; spaces : in Natural := 0);
  

  private

    type Tree_Node is record
        node_name   : Unbounded_String;
        data        : Metadata;
        parent_node : Tree_Node_Pointer;
        child_node  : TN_DLL.DoubleLinkedList_Pointer;
  end record;

end p_datastruct_tree;
