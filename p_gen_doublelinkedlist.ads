with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

generic
   type T_Value is private;
   with function "=" (X,Y : IN T_Value) return Boolean;
   with function image(element : IN T_Value) return String;

package p_gen_doublelinkedlist is

   type DoubleLinkedList_Cell is private;
   type DoubleLinkedList_Pointer is private;

   function get_value(list : IN DoubleLinkedList_Pointer) return T_Value;
   procedure set_value(value : IN T_Value; list : IN OUT DoubleLinkedList_Pointer);
   function get_previous(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_previous(pointer : IN DoubleLinkedList_Pointer; list : IN OUT DoubleLinkedList_Pointer);
   function get_next(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure set_next(pointer : IN DoubleLinkedList_Pointer; list : IN OUT DoubleLinkedList_Pointer);
   procedure set_dll_cell(out_cell : OUT DoubleLinkedList_Pointer; in_cell : IN DoubleLinkedList_Pointer);
   function set_null_cell return DoubleLinkedList_Pointer;

   function get_first(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   function get_last(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;

   function is_empty(list : IN DoubleLinkedList_Pointer) return Boolean;
   function length(list : IN DoubleLinkedList_Pointer) return Natural;
   --function is_unique(elem : IN T_Value; list : IN DoubleLinkedList_Pointer) return Boolean;
   procedure insert_at_start(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer);
   procedure insert_at_end(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer);
   procedure insert_after(elem : IN T_Value; delimiter : IN T_Value; list : IN OUT DoubleLinkedList_Pointer);
   procedure delete(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer);
   function find(elem : IN T_Value; list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer;
   procedure display(list : IN DoubleLinkedList_Pointer);

private

   type DoubleLinkedList_Pointer is access DoubleLinkedList_Cell;

   type DoubleLinkedList_Cell is record
      value : T_Value;
      previous : DoubleLinkedList_Pointer;
      next : DoubleLinkedList_Pointer;
   end record;

end p_gen_doublelinkedlist;
