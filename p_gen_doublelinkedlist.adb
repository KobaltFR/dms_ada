with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body p_gen_doublelinkedlist is

   function get_value (list : in DoubleLinkedList_Pointer) return T_Value is
   begin
      return list.value;
   end get_value;

   procedure set_value
     (value : in T_Value; list : in out DoubleLinkedList_Pointer)
   is
   begin
      list.value := value;
   end set_value;

   function get_previous
     (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer
   is
   begin
      return list.previous;
   end get_previous;

   procedure set_previous
     (pointer : in     DoubleLinkedList_Pointer;
      list    : in out DoubleLinkedList_Pointer)
   is
   begin
      list.previous := pointer;
   end set_previous;

   function get_next
     (list : in DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer
   is
   begin
      return list.next;
   end get_next;

   procedure set_next
     (pointer : in     DoubleLinkedList_Pointer;
      list    : in out DoubleLinkedList_Pointer)
   is
   begin
      list.next := pointer;
   end set_next;

   procedure set_dll_cell
     (out_cell :    out DoubleLinkedList_Pointer;
      in_cell  : in     DoubleLinkedList_Pointer)
   is
   begin
      out_cell := in_cell;
   end set_dll_cell;

   function set_null_cell return DoubleLinkedList_Pointer is
   begin
      return null;
   end set_null_cell;

   function get_last (list : in DoubleLinkedList_Pointer) return T_Value is
      tmp : DoubleLinkedList_Pointer := list;
   begin
      while not is_empty(get_next(tmp)) loop
         set_dll_cell(tmp, get_next(tmp));
      end loop;
      return tmp.value;
   end get_last;

   procedure get_and_delete_last
     (list : in out DoubleLinkedList_Pointer; last : out T_Value)
   is
      tmp : DoubleLinkedList_Pointer;
   begin
      goto_first_element(list);
      tmp := list;
      while not is_empty(get_next(tmp)) loop
         set_dll_cell(tmp, get_next(tmp));
      end loop;
      last := tmp.value;
      if length(list) = 1 then
         list := null;
      else
         tmp.previous.next := null;
         tmp.previous := null;
      end if;
   end get_and_delete_last;

   function is_empty (list : in DoubleLinkedList_Pointer) return Boolean is
   begin
      return list = null;
   end is_empty;

   function length (list : in DoubleLinkedList_Pointer) return Natural is
   begin
      if is_empty (list) then
         return 0;
      else
         return 1 + length (list.next);
      end if;
   end length;

   procedure insert_at_start
     (elem : in T_Value; list : in out DoubleLinkedList_Pointer)
   is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty (list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := list;
         while tmp.previous /= null loop
            tmp := tmp.previous;
         end loop;
         tmp.previous := new DoubleLinkedList_Cell'(elem, null, tmp);
      end if;
   end insert_at_start;

   procedure insert_at_end
     (elem : in T_Value; list : in out DoubleLinkedList_Pointer)
   is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty (list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := list;
         while tmp.next /= null loop
            tmp := tmp.next;
         end loop;
         tmp.next := new DoubleLinkedList_Cell'(elem, tmp, null);
      end if;
   end insert_at_end;

   procedure insert_after
     (elem : in     T_Value; delimiter : in T_Value;
      list : in out DoubleLinkedList_Pointer)
   is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty (list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := find (delimiter, list);
         if tmp.next = null then
            tmp.next := new DoubleLinkedList_Cell'(elem, tmp, null);
         else
            tmp.next := new DoubleLinkedList_Cell'(elem, tmp, tmp.next);
            tmp.next.next.previous := tmp.next;
         end if;
      end if;
   end insert_after;

   function find
     (elem : in T_Value; list : in DoubleLinkedList_Pointer)
      return DoubleLinkedList_Pointer
   is
      tmp           : DoubleLinkedList_Pointer := list;
      element_found : Boolean                  := False;
   begin

      if is_empty (list) then
         return null;
      end if;

      while not element_found and then tmp /= null loop
         if tmp.value = elem then
            element_found := True;
         else
            tmp := tmp.next;
         end if;
      end loop;

      if not element_found then
         tmp := list;

         while not element_found and then tmp /= null loop
            if tmp.value = elem then
               element_found := True;
            else
               tmp := tmp.previous;
            end if;
         end loop;
      end if;

      return tmp;

   end find;

   procedure delete (elem : in T_Value; list : in out DoubleLinkedList_Pointer)
   is
      original_DLL : DoubleLinkedList_Pointer;
   begin
      original_DLL := list;
      if elem = list.value then
         if list.previous = null then
            list          := list.next;
            list.previous := null;
         else
            list      := list.previous;
            list.next := list.next.next;
         end if;
      else
         list := find (elem, list);
         if list /= original_DLL then
            if list.previous = null then
               list          := list.next;
               list.previous := null;
            else
               list      := list.previous;
               list.next := list.next.next;
            end if;
         else
            Put_Line ("The element '" & image (elem) & "' wasn't found...");
         end if;
      end if;
   end delete;

   procedure display (list : in DoubleLinkedList_Pointer) is
      tmp : DoubleLinkedList_Pointer;
   begin
      if list = null then
         Put_Line ("The Double Linked List is empty !");
      else
         tmp := list;
         while tmp.previous /= null loop
            tmp := tmp.previous;
         end loop;
         while tmp /= null loop
            Put (image (tmp.value));
            Put (" ");
            tmp := tmp.next;
         end loop;
         New_Line;
      end if;
   end display;

   procedure goto_first_element (list : in out DoubleLinkedList_Pointer) is
   begin
      if list /= null then
         while list.previous /= null loop
            list := list.previous;
         end loop;
      end if;
   end goto_first_element;

end p_gen_doublelinkedlist;
