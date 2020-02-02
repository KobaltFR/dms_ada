with Ada.Strings.Unbounded, p_metadata, p_gen_doublelinkedlist;
use Ada.Strings.Unbounded, p_metadata;

package p_datastruct_tree is

   type Tree_Node is private;
   type Tree_Node_Pointer is access Tree_Node;

   function equals
     (node1 : in Tree_Node_Pointer; node2 : in Tree_Node_Pointer)
      return Boolean;
   function print (node : in Tree_Node_Pointer) return String;

   package TN_DLL is new p_gen_doublelinkedlist (T_Value => Tree_Node_Pointer,
      "=" => equals, image => print);
   use TN_DLL;

   package US_DLL is new p_gen_doublelinkedlist (T_Value => Unbounded_String,
      "=" => "=", image => To_String);
   use US_DLL;

   INEXISTANT_ELEMENT : exception;
   NOT_UNIQUE_ELEMENT : exception;
   NOT_FOLDER_ELEMENT : exception;


   function get_node_name
     (node : in Tree_Node_Pointer) return Unbounded_String;
   procedure set_node_name
     (name : in Unbounded_String; node : in out Tree_Node_Pointer);
   function get_metadata (node : in Tree_Node_Pointer) return Metadata;
   procedure set_metadata
     (data : in Metadata; node : in out Tree_Node_Pointer);
   function get_parent_node
     (node : in Tree_Node_Pointer) return Tree_Node_Pointer;
   procedure set_parent_node
     (pointer : in Tree_Node_Pointer; node : in out Tree_Node_Pointer);
   function get_child_node
     (node : in Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer;
   procedure set_child_node
     (child_list : in     TN_DLL.DoubleLinkedList_Pointer;
      node       : in out Tree_Node_Pointer);
   procedure set_tree_node
     (out_node : out Tree_Node_Pointer; in_node : in Tree_Node_Pointer);

   function init
     (name     : in Unbounded_String; data : in Metadata;
      parent   : in Tree_Node_Pointer;
      children : in TN_DLL.DoubleLinkedList_Pointer) return Tree_Node_Pointer;
   function is_empty (node : in Tree_Node_Pointer) return Boolean;
   procedure insert
     (path_to_node : in US_DLL.DoubleLinkedList_Pointer; data : in Metadata;
      current_node : in Tree_Node_Pointer);
   procedure goto_node
     (path_to_node : in US_DLL.DoubleLinkedList_Pointer;
      current_node : in out Tree_Node_Pointer);
   procedure delete
     (path_to_node : in     US_DLL.DoubleLinkedList_Pointer;
      current_node : in Tree_Node_Pointer);
   procedure display
     (current_node : in Tree_Node_Pointer; recusively : in Boolean := False; detailed : in Boolean := False; spaces : in Natural := 0);
   function find_child
     (element : in Unbounded_String; current_node : in Tree_Node_Pointer)
      return TN_DLL.DoubleLinkedList_Pointer;
   function is_unique
     (name     : in Unbounded_String;
      children : in TN_DLL.DoubleLinkedList_Pointer) return Boolean;
   procedure goto_root (current_node : in out Tree_Node_Pointer);

   function get_node_for_alphabetical_insert
     (name : in Unbounded_String; dll : in TN_DLL.DoubleLinkedList_Pointer)
      return TN_DLL.DoubleLinkedList_Pointer;
   procedure alphabetical_insert
     (node_to_insert : in     Tree_Node_Pointer;
      dll            : in out TN_DLL.DoubleLinkedList_Pointer);

private

   type Tree_Node is record
      node_name   : Unbounded_String;
      data        : Metadata;
      parent_node : Tree_Node_Pointer;
      child_node  : TN_DLL.DoubleLinkedList_Pointer;
   end record;

end p_datastruct_tree;
