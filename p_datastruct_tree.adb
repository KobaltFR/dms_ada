with Ada.Text_IO, Ada.Strings.unbounded, p_metadata, p_commandfuncs, p_gen_doublelinkedlist;
use Ada.Text_IO, Ada.Strings.unbounded, p_metadata, p_commandfuncs;

package body p_datastruct_tree is

   function equals(node1 : IN Tree_Node_Pointer; node2 : IN Tree_Node_Pointer) return Boolean is
   begin
      return node1.node_name = node2.node_name;
   end equals;

   function print(node : IN Tree_Node_Pointer) return String is
   begin
      return To_String(node.node_name);
   end print;

   function get_node_name(node : IN Tree_Node_Pointer) return Unbounded_String is
   begin
      return node.node_name;
   end get_node_name;

   procedure set_node_name(name : IN Unbounded_String; node : IN OUT Tree_Node_Pointer) is
   begin
      node.node_name := name;
   end set_node_name;

   function get_metadata(node : IN Tree_Node_Pointer) return Metadata is
   begin
      return node.data;
   end get_metadata;

   procedure set_metadata(data : IN Metadata; node : IN OUT Tree_Node_Pointer) is
   begin
      node.data := data;
   end set_metadata;

   function get_parent_node(node : IN Tree_Node_Pointer) return Tree_Node_Pointer is
   begin
      return node.parent_node;
   end get_parent_node;

   procedure set_parent_node(pointer : IN Tree_Node_Pointer; node : IN OUT Tree_Node_Pointer) is
   begin
      node.parent_node := pointer;
   end set_parent_node;

   function get_child_node(node : IN Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
   begin
      return node.child_node;
   end get_child_node;

   procedure set_child_node(child_list : IN TN_DLL.DoubleLinkedList_Pointer; node : IN OUT Tree_Node_Pointer) is
   begin
      node.child_node := child_list;
   end set_child_node;

   procedure set_tree_node(out_node : OUT Tree_Node_Pointer; in_node : IN Tree_Node_Pointer) is
   begin
      out_node := in_node;
   end set_tree_node;

   --Returns null if you need to add at the start, or the privous element of the location you need to insert at.
   function get_node_for_alphabetical_insert(name : IN Unbounded_String; dll : IN TN_DLL.DoubleLinkedList_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      tmp : TN_DLL.DoubleLinkedList_Pointer := dll;
      spot : TN_DLL.DoubleLinkedList_Pointer := set_null_cell;
      found_spot : Boolean := False;
   begin

      while (not is_empty(tmp)) and then (not found_spot) loop
         if get_node_name(get_value(tmp)) > name then
            found_spot := True;
         elsif get_node_name(get_value(tmp)) < name then
            if is_empty(get_next(tmp)) then
               set_dll_cell(out_cell => spot, in_cell => tmp);
               found_spot := True;
            elsif get_node_name(get_value(get_next(tmp))) > name then
               set_dll_cell(out_cell => spot, in_cell => tmp);
               found_spot := True;
            else
               set_dll_cell(tmp, get_next(tmp));
            end if;
         end if;
      end loop;

      return spot;
   end get_node_for_alphabetical_insert;

   procedure alphabetical_insert(node_to_insert : IN Tree_Node_Pointer; dll : IN OUT TN_DLL.DoubleLinkedList_Pointer) is
      insert_after_node : TN_DLL.DoubleLinkedList_Pointer;
   begin
      insert_after_node := get_node_for_alphabetical_insert(get_node_name(node_to_insert), dll);
      if is_empty(insert_after_node) then
         insert_at_start(node_to_insert, dll);
      else
         insert_after(node_to_insert, get_value(insert_after_node), dll);
      end if;
   end alphabetical_insert;

   function init(name : IN Unbounded_String; data : IN Metadata; parent : IN Tree_Node_Pointer; children : IN TN_DLL.DoubleLinkedList_Pointer) return Tree_Node_Pointer is
   begin
      return new Tree_Node'(name, data, parent, children);
   end init;

   function is_empty(node : IN Tree_Node_Pointer) return Boolean is
   begin
      return node = null;
   end is_empty;

   procedure insert(path_to_node : IN Unbounded_String; data : IN Metadata; current_node : IN OUT Tree_Node_Pointer) is
      path_list : US_DLL.DoubleLinkedList_Pointer;
      node_name : Unbounded_String;
      changed_node_children : TN_DLL.DoubleLinkedList_Pointer;
      changed_node : Tree_Node_Pointer;
   begin
      path_list := split_command('/', path_to_node);
      node_name := US_DLL.get_value(US_DLL.get_last(path_list));
      US_DLL.delete(node_name, path_list);
      changed_node := p_datastruct_tree.get_node(path_list, current_node);
      changed_node_children := get_child_node(changed_node);
      if is_unique(node_name, changed_node_children) then
         alphabetical_insert(new Tree_Node'(node_name, data, current_node, set_null_cell), changed_node_children);
      else
         raise not_unique_element;
      end if;
   end insert;

   function find_child(element : IN Unbounded_String; current_node : IN Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      tmp : TN_DLL.DoubleLinkedList_Pointer := get_child_node(current_node);
      element_found : Boolean := False;
   begin

      if TN_DLL.is_empty(tmp) then
         return set_null_cell;
      end if;

      while (not is_empty(tmp)) and then (not element_found) loop
         if get_node_name(get_value(tmp)) = element then
            element_found := True;
         else
            set_dll_cell(tmp, get_next(tmp));
         end if;
      end loop;

      if (not element_found) then
         tmp := get_child_node(current_node);
         while (not is_empty(tmp)) and then (not element_found) loop
            if get_node_name(get_value(tmp)) = element then
               element_found := True;
            else
               set_dll_cell(tmp, get_previous(tmp));
            end if;
         end loop;
      end if;

      return tmp;
   end find_child;

   function is_unique(name : IN Unbounded_String; children : IN TN_DLL.DoubleLinkedList_Pointer) return Boolean is
      tmp : TN_DLL.DoubleLinkedList_Pointer := children;
      unique : Boolean := True;
   begin
      while not is_empty(tmp) and then unique loop
         if name = get_node_name(get_value(tmp)) then
            unique := False;
         end if;
         set_dll_cell(tmp, get_next(tmp));
      end loop;
      return unique;
   end is_unique;

   function get_node(path_to_node : IN US_DLL.DoubleLinkedList_Pointer; current_node : IN Tree_Node_Pointer) return Tree_Node_Pointer is
      found_element : TN_DLL.DoubleLinkedList_Pointer;
   begin
      if not US_DLL.is_empty(path_to_node) then
         found_element := find_child(US_DLL.get_value(path_to_node), current_node);
         if not TN_DLL.is_empty(found_element) then
            return get_node(US_DLL.get_next(path_to_node), get_value(found_element));
         else
            raise element_not_found;
         end if;
      end if;
      return null;
   end get_node;

   procedure delete(path_to_node : IN US_DLL.DoubleLinkedList_Pointer; current_node : IN OUT Tree_Node_Pointer) is
      path_list : US_DLL.DoubleLinkedList_Pointer := path_to_node;
      node_name : Unbounded_String;
      changed_node : Tree_Node_Pointer;
      changed_node_children : TN_DLL.DoubleLinkedList_Pointer;
      found_element : TN_DLL.DoubleLinkedList_Pointer;
   begin
      node_name := US_DLL.get_value(US_DLL.get_last(path_list));
      US_DLL.delete(node_name, path_list);
      changed_node := p_datastruct_tree.get_node(path_list, current_node);
      found_element := find_child(US_DLL.get_value(path_to_node), changed_node);
      if not TN_DLL.is_empty(found_element) then
         changed_node_children := get_child_node(changed_node);
         TN_DLL.delete(get_value(found_element), changed_node_children);
      else
         raise element_not_found;
      end if;
   end delete;

   procedure display(current_node : IN Tree_Node_Pointer; spaces : IN Natural := 0) is

      procedure put_space(n : IN Natural) is
      begin
         for i in 1..n loop
            Put(' ');
         end loop;
      end put_space;

      current_node_children : TN_DLL.DoubleLinkedList_Pointer;
      nb_of_spaces : Natural := spaces;
      folder_character : Character;

   begin

      if not is_empty(current_node) then

         if get_user_rights(get_metadata(current_node))(1) = 'd' and then get_node_name(current_node) /= To_Unbounded_String("/") then
            folder_character := '/';
         else
            folder_character := ' ';
         end if;
         Put_Line(print(current_node) & folder_character);
         current_node_children := get_child_node(current_node);
         nb_of_spaces := nb_of_spaces + 4;

         while not is_empty(current_node_children) loop

            put_space(nb_of_spaces);
            display(get_value(current_node_children), nb_of_spaces);
            set_dll_cell(current_node_children, get_next(current_node_children));

         end loop;

      end if;

   end display;

   procedure go_to_root(current_node : IN OUT Tree_Node_Pointer) is
   begin
      if not is_empty(current_node) then
         set_tree_node(current_node, get_parent_node(current_node));
         go_to_root(current_node);
      end if;
   end go_to_root;

end p_datastruct_tree;
