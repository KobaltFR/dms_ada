with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body p_gen_doublelinkedlist is

   function get_value(list : IN DoubleLinkedList_Pointer) return T_Value is
   begin
      return list.value;
   end get_value;

   procedure set_value(value : IN T_Value; list : IN OUT DoubleLinkedList_Pointer) is
   begin
      list.value := value;
   end set_value;

   function get_previous(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer is
   begin
      return list.previous;
   end get_previous;

   procedure set_previous(pointer : IN DoubleLinkedList_Pointer; list : IN OUT DoubleLinkedList_Pointer) is
   begin
      list.previous := pointer;
   end set_previous;

   function get_next(list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer is
   begin
      return list.next;
   end get_next;

   procedure set_next(pointer : IN DoubleLinkedList_Pointer; list : IN OUT DoubleLinkedList_Pointer) is
   begin
      list.next := pointer;
   end set_next;

   procedure set_dll_cell(out_cell : OUT DoubleLinkedList_Pointer; in_cell : IN DoubleLinkedList_Pointer) is
   begin
      out_cell := in_cell;
   end set_dll_cell;

   function set_null_cell return DoubleLinkedList_Pointer is
   begin
      return null;
   end set_null_cell;

   function is_empty(list : IN DoubleLinkedList_Pointer) return Boolean is
   begin
      return list = null;
   end is_empty;

   function length(list : IN DoubleLinkedList_Pointer) return Natural is
   begin
      if is_empty(list) then
         return 0;
      else
         return 1 + length(list.next);
      end if;
   end length;

   function is_unique(elem : IN T_Value; list : IN DoubleLinkedList_Pointer) return Boolean is
   begin
      return find(elem, list) = null;
   end is_unique;

   procedure insert_at_start(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer) is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty(list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := list;
         while tmp.previous /= null loop
            tmp := tmp.previous;
         end loop;
         tmp.previous := new DoubleLinkedList_Cell'(elem, null, tmp);
      end if;
   end insert_at_start;

   procedure insert_at_end(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer) is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty(list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := list;
         while tmp.next /= null loop
            tmp := tmp.next;
         end loop;
         tmp.next := new DoubleLinkedList_Cell'(elem, tmp, null);
      end if;
   end insert_at_end;

   procedure insert_after(elem : IN T_Value; delimiter : IN T_Value; list : IN OUT DoubleLinkedList_Pointer) is
      tmp : DoubleLinkedList_Pointer;
   begin
      if is_empty(list) then
         list := new DoubleLinkedList_Cell'(elem, null, null);
      else
         tmp := find(delimiter,list);
         if tmp.next = null then
            tmp.next := new DoubleLinkedList_Cell'(elem, tmp, null);
         else
            tmp.next := new DoubleLinkedList_Cell'(elem, tmp, tmp.next);
            tmp.next.next.previous := tmp.next;
         end if;
      end if;
   end insert_after;

   function find(elem : IN T_Value; list : IN DoubleLinkedList_Pointer) return DoubleLinkedList_Pointer is
      tmp : DoubleLinkedList_Pointer := list;
      element_found : Boolean := False;
   begin

      if is_empty(list) then
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

   procedure delete(elem : IN T_Value; list : IN OUT DoubleLinkedList_Pointer) is
      original_DLL : DoubleLinkedList_Pointer;
   begin
      original_DLL := list;
      if elem = list.value then
         if list.previous = null then
            list := list.next;
            list.previous := null;
         else
            list := list.previous;
            list.next := list.next.next;
         end if;
      else
         list := find(elem, list);
         if list /= original_DLL then
            if list.previous = null then
               list := list.next;
               list.previous := null;
            else
               list := list.previous;
               list.next := list.next.next;
            end if;
         else
            Put_Line("The element '"& image(elem) &"' wasn't found...");
         end if;
      end if;
   end delete;

   procedure display(list : IN DoubleLinkedList_Pointer) is
      tmp : DoubleLinkedList_Pointer;
   begin
      if list = null then
         Put_Line("The Double Linked List is empty !");
      else
         tmp := list;
         while tmp.previous /= null loop
            tmp := tmp.previous;
         end loop;
         while tmp /= null loop
            Put(image(tmp.value));
            Put(" ");
            tmp := tmp.next;
         end loop;
         New_Line;
      end if;
   end display;

end p_gen_doublelinkedlist;
