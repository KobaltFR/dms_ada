with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
   type T_Value is private;
   with function "=" (X, Y : in T_Value) return Boolean;
   with function image (element : in T_Value) return String;

package p_gen_doublelinkedlist is

   type DoubleLinkedList_Cell is private;
   type DoubleLinkedList_Pointer is private;

   ELEMENT_NOT_FOUND : exception;

   function get_value (list : in DoubleLinkedList_Pointer) return T_Value;
   procedure set_value (value : in T_Value; list : in out DoubleLinkedList_Pointer);
   function get_previous (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_previous (pointer : in DoubleLinkedList_Pointer; list : in out DoubleLinkedList_Pointer);
   function get_next (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_next (pointer : in DoubleLinkedList_Pointer; list : in out DoubleLinkedList_Pointer);

   -- Name: set_dll_cell
   -- Semantics: Sets a whole new double linked list cell to a given one
   -- Parameters:
   --      • out_cell : The cell that will be changed
   --      • in_cell : The cell that you want to change to
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   procedure set_dll_cell (out_cell : out DoubleLinkedList_Pointer; in_cell : in DoubleLinkedList_Pointer);

   -- Name: set_null_cell
   -- Semantics: Sets a cell to null
   -- Parameters: /
   -- Return type: A pointer to a Double Linked List cell
   -- Preconditions: /
   -- Postconditions: /
   function set_null_cell return DoubleLinkedList_Pointer;

   -- Name: get_last
   -- Semantics: Returns the last element of a given list
   -- Parameters:
   --      • list : The list that you want the last element from
   -- Return type: Generic value of the list
   -- Preconditions: /
   -- Postconditions: /
   function get_last (list : in DoubleLinkedList_Pointer) return T_Value;

   -- Name: get_and_delete_last
   -- Semantics: 'last' takes the value of the last element of a given list, and delete this element from the list
   -- Parameters:
   --      • list : The list that you want the last element from
   -- Return type: /
   -- Preconditions: /
   -- Postconditions: /
   procedure get_and_delete_last (list : in out DoubleLinkedList_Pointer; last : out T_Value);

   function is_empty (list : in DoubleLinkedList_Pointer) return Boolean;
   
   -- Returns the number of elements in the list
   function length (list : in DoubleLinkedList_Pointer) return Natural;

   --Inserts the element at the start of the list
   procedure insert_at_start (elem : in T_Value; list : in out DoubleLinkedList_Pointer);

   --Inserts the element at the end of the list
   procedure insert_at_end (elem : in T_Value; list : in out DoubleLinkedList_Pointer);

   --Inserts the element after a given element of the list
   procedure insert_after (elem : in T_Value; delimiter : in T_Value; list : in out DoubleLinkedList_Pointer);

   --Deletes a given element of the list
   procedure delete (elem : in T_Value; list : in out DoubleLinkedList_Pointer);

   --Retuns the the pointer to a double linked list cell that contains the generic value 'elem', or null if none of the cells containts this value
   function find (elem : in T_Value; list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;

   procedure display (list : in DoubleLinkedList_Pointer);

   --Moves the pointer to the start of the double linked list
   procedure goto_first_element (list : in out DoubleLinkedList_Pointer);

private

   type DoubleLinkedList_Pointer is access DoubleLinkedList_Cell;

   type DoubleLinkedList_Cell is record
      value    : T_Value;
      previous : DoubleLinkedList_Pointer;
      next     : DoubleLinkedList_Pointer;
   end record;

end p_gen_doublelinkedlist;
