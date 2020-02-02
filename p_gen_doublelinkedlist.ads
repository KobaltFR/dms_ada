with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

generic
   type T_Value is private;
   with function "=" (X, Y : in T_Value) return Boolean;
   with function image (element : in T_Value) return String;

package p_gen_doublelinkedlist is

   type DoubleLinkedList_Cell is private;
   type DoubleLinkedList_Pointer is private;

   function get_value (list : in DoubleLinkedList_Pointer) return T_Value;
   procedure set_value
     (value : in T_Value; list : in out DoubleLinkedList_Pointer);
   function get_previous
     (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_previous
     (pointer : in     DoubleLinkedList_Pointer;
      list    : in out DoubleLinkedList_Pointer);
   function get_next
     (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_next
     (pointer : in     DoubleLinkedList_Pointer;
      list    : in out DoubleLinkedList_Pointer);
   procedure set_dll_cell
     (out_cell :    out DoubleLinkedList_Pointer;
      in_cell  : in     DoubleLinkedList_Pointer);
   function set_null_cell return DoubleLinkedList_Pointer;

   function get_last (list : in DoubleLinkedList_Pointer) return T_Value;

   procedure get_and_delete_last
     (list : in out DoubleLinkedList_Pointer; last : out T_Value);

   function is_empty (list : in DoubleLinkedList_Pointer) return Boolean;
   function length (list : in DoubleLinkedList_Pointer) return Natural;
   procedure insert_at_start
     (elem : in T_Value; list : in out DoubleLinkedList_Pointer);
   procedure insert_at_end
     (elem : in T_Value; list : in out DoubleLinkedList_Pointer);
   procedure insert_after
     (elem : in     T_Value; delimiter : in T_Value;
      list : in out DoubleLinkedList_Pointer);
   procedure delete
     (elem : in T_Value; list : in out DoubleLinkedList_Pointer);
   function find
     (elem : in T_Value; list : in DoubleLinkedList_Pointer)
      return DoubleLinkedList_Pointer;
   procedure display (list : in DoubleLinkedList_Pointer);
   procedure goto_first_element (list : in out DoubleLinkedList_Pointer);

private

   type DoubleLinkedList_Pointer is access DoubleLinkedList_Cell;

   type DoubleLinkedList_Cell is record
      value    : T_Value;
      previous : DoubleLinkedList_Pointer;
      next     : DoubleLinkedList_Pointer;
   end record;

end p_gen_doublelinkedlist;
