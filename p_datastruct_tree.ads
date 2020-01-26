with Ada.Strings.unbounded, p_metadata, p_gen_doublelinkedlist;
use Ada.Strings.unbounded, p_metadata;

package p_datastruct_tree is

   type Tree_Node is private;
   type Tree_Node_Pointer is access Tree_Node;

   function equals(node1 : IN Tree_Node_Pointer; node2 : IN Tree_Node_Pointer) return Boolean;
   function print(node : IN Tree_Node_Pointer) return String;

   package TN_DLL is new p_gen_doublelinkedlist(T_Value => Tree_Node_Pointer, "=" => equals, image => print);
   use TN_DLL;

   function get_node_name(node : IN Tree_Node_Pointer) return Unbounded_String;
   procedure set_node_name(name : IN Unbounded_String; node : IN OUT Tree_Node_Pointer);
   function get_metadata(node : IN Tree_Node_Pointer) return Metadata;
   procedure set_metadata(data : IN Metadata; node : IN OUT Tree_Node_Pointer);
   function get_parent_node(node : IN Tree_Node_Pointer) return Tree_Node_Pointer;
   procedure set_parent_node(pointer : IN Tree_Node_Pointer; node : IN OUT Tree_Node_Pointer);
   function get_child_node(node : IN Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer;
   procedure set_child_node(child_list : IN TN_DLL.DoubleLinkedList_Pointer; node : IN OUT Tree_Node_Pointer);
   procedure set_tree_node(out_node : OUT Tree_Node_Pointer; in_node : IN Tree_Node_Pointer);

   function init return Tree_Node_Pointer;
   function is_empty(node : IN Tree_Node_Pointer) return Boolean;
   procedure insert(path_to_node : IN Unbounded_String; data : IN Metadata; current_node : IN OUT Tree_Node_Pointer);
   function get_node(path_to_node : IN Unbounded_String; current_node : IN Tree_Node_Pointer) return Tree_Node_Pointer;
   procedure delete(path_to_node : IN Unbounded_String; current_node : IN OUT Tree_Node_Pointer);
   procedure display(current_node : IN Tree_Node_Pointer; space: IN Integer := 0);

private

   type Tree_Node is record
      node_name : Unbounded_String;
      data : Metadata;
      parent_node : Tree_Node_Pointer;
      child_node : TN_DLL.DoubleLinkedList_Pointer;
   end record;

   function alphabetical_insert_after(name : IN Unbounded_String; dll : IN TN_DLL.DoubleLinkedList_Pointer) return TN_DLL.DoubleLinkedList_Pointer;

end p_datastruct_tree;