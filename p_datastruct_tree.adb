with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, p_metadata;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded, p_metadata;

package body p_datastruct_tree is

   function equals (node1 : in Tree_Node_Pointer; node2 : in Tree_Node_Pointer) return Boolean is
   begin
      return node1.node_name = node2.node_name;
   end equals;

   function print (node : in Tree_Node_Pointer) return String is
   begin
      return To_String (node.node_name);
   end print;



   function get_node_name (node : in Tree_Node_Pointer) return Unbounded_String is
   begin
      return node.node_name;
   end get_node_name;

   procedure set_node_name (name : in Unbounded_String; node : in out Tree_Node_Pointer) is
   begin
      node.node_name := name;
   end set_node_name;


   function get_metadata (node : in Tree_Node_Pointer) return Metadata is
   begin
      return node.data;
   end get_metadata;

   procedure set_metadata (data : in Metadata; node : in out Tree_Node_Pointer) is
   begin
      node.data := data;
   end set_metadata;


   function get_parent_node (node : in Tree_Node_Pointer) return Tree_Node_Pointer is
   begin
      return node.parent_node;
   end get_parent_node;

   procedure set_parent_node (pointer : in Tree_Node_Pointer; node : in out Tree_Node_Pointer) is
   begin
      node.parent_node := pointer;
   end set_parent_node;


   function get_child_node (node : in Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      node_dll : TN_DLL.DoubleLinkedList_Pointer;
   begin
      node_dll := node.child_node;
      goto_first_element(node_dll);
      return node_dll;
   end get_child_node;

   procedure set_child_node (child_list : in TN_DLL.DoubleLinkedList_Pointer; node : in out Tree_Node_Pointer) is
   begin
      node.child_node := child_list;
   end set_child_node;


   procedure set_tree_node (out_node : out Tree_Node_Pointer; in_node : in Tree_Node_Pointer) is
   begin
      out_node := in_node;
   end set_tree_node;



   --Returns null if you need to add at the start, or the privous element of the location you need to insert at.
   function get_node_for_alphabetical_insert (name : in Unbounded_String; dll : in TN_DLL.DoubleLinkedList_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      tmp        : TN_DLL.DoubleLinkedList_Pointer := dll;
      spot       : TN_DLL.DoubleLinkedList_Pointer := set_null_cell;
      found_spot : Boolean                         := False;
   begin
      while (not is_empty (tmp)) and then (not found_spot) loop
         if get_node_name (get_value (tmp)) > name then
            found_spot := True;
         elsif get_node_name (get_value (tmp)) < name then
            if is_empty (get_next (tmp)) then
               set_dll_cell (out_cell => spot, in_cell => tmp);
               found_spot := True;
            elsif get_node_name (get_value (get_next (tmp))) > name then
               set_dll_cell (out_cell => spot, in_cell => tmp);
               found_spot := True;
            else
               set_dll_cell (tmp, get_next (tmp));
            end if;
         end if;
      end loop;
      return spot;
   end get_node_for_alphabetical_insert;


   procedure alphabetical_insert (node_to_insert : in Tree_Node_Pointer; dll : in out TN_DLL.DoubleLinkedList_Pointer) is
      insert_after_node : TN_DLL.DoubleLinkedList_Pointer;
   begin
      insert_after_node :=
        get_node_for_alphabetical_insert (get_node_name (node_to_insert), dll);
      if is_empty (insert_after_node) then
         insert_at_start (node_to_insert, dll);
      else
         insert_after (node_to_insert, get_value (insert_after_node), dll);
      end if;
   end alphabetical_insert;



   function init (name : in Unbounded_String; data : in Metadata; parent : in Tree_Node_Pointer; children : in TN_DLL.DoubleLinkedList_Pointer) return Tree_Node_Pointer is
   begin
      return new Tree_Node'(name, data, parent, children);
   end init;


   function is_empty (node : in Tree_Node_Pointer) return Boolean is
   begin
      return node = null;
   end is_empty;


   function is_unique (name : in Unbounded_String; children : in TN_DLL.DoubleLinkedList_Pointer) return Boolean is
      tmp    : TN_DLL.DoubleLinkedList_Pointer := children;
      unique : Boolean                         := True;
   begin
      while not is_empty (tmp) and then unique loop
         if name = get_node_name (get_value (tmp)) then
            unique := False;
         end if;
         set_dll_cell (tmp, get_next (tmp));
      end loop;
      return unique;
   end is_unique;


   function find_child (element_name : in Unbounded_String; current_node : in Tree_Node_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      tmp : TN_DLL.DoubleLinkedList_Pointer := get_child_node (current_node);
      element_found : Boolean                         := False;
   begin
      if TN_DLL.is_empty (tmp) then
         return set_null_cell;
      end if;
      while (not is_empty (tmp)) and then (not element_found) loop
         if get_node_name (get_value (tmp)) = element_name then
            element_found := True;
         else
            set_dll_cell (tmp, get_next (tmp));
         end if;
      end loop;
      if (not element_found) then
         tmp := get_child_node (current_node);
         while (not is_empty (tmp)) and then (not element_found) loop
            if get_node_name (get_value (tmp)) = element_name then
               element_found := True;
            else
               set_dll_cell (tmp, get_previous (tmp));
            end if;
         end loop;
      end if;
      return tmp;
   end find_child;


   procedure goto_root (current_node : in out Tree_Node_Pointer) is
   begin
      if not is_empty (get_parent_node (current_node)) then
         set_tree_node (current_node, get_parent_node (current_node));
         goto_root (current_node);
      end if;
   end goto_root;


   --WORKS ONLY WITH RELATIVE PATHS
   procedure goto_node (path_to_node : in US_DLL.DoubleLinkedList_Pointer; current_node : in out Tree_Node_Pointer) is
      found_element : TN_DLL.DoubleLinkedList_Pointer;
      tmp_path : US_DLL.DoubleLinkedList_Pointer := path_to_node;
      parent_node : Tree_Node_Pointer;
   begin
      while not US_DLL.is_empty(tmp_path) loop
         if US_DLL.get_value (tmp_path) = To_Unbounded_String(".") or else US_DLL.get_value (tmp_path) = To_Unbounded_String("") then
            null;
         elsif US_DLL.get_value (tmp_path) = To_Unbounded_String("..") then
            parent_node := get_parent_node(current_node);
            if parent_node = null then
               null;
            else
               current_node := parent_node;
            end if;
         else
            found_element := find_child (US_DLL.get_value (tmp_path), current_node);
            if not TN_DLL.is_empty (found_element) then
               if get_user_rights(get_metadata(get_value(found_element)))(1) = 'd' then
                  current_node := TN_DLL.get_value(found_element);
               else
                  raise NOT_FOLDER_ELEMENT;
               end if;
            else
               raise INEXISTANT_ELEMENT;
            end if;
         end if;
         US_DLL.set_dll_cell(tmp_path, US_DLL.get_next(tmp_path));
      end loop;
   end goto_node;


   procedure insert (path_to_node : in US_DLL.DoubleLinkedList_Pointer; data : in Metadata; current_node : in Tree_Node_Pointer) is
      path_list             : US_DLL.DoubleLinkedList_Pointer := path_to_node;
      node_name             : Unbounded_String;
      changed_node : Tree_Node_Pointer := current_node;
      changed_node_children : TN_DLL.DoubleLinkedList_Pointer;
   begin
      US_DLL.get_and_delete_last(path_list, node_name);
      if not US_DLL.is_empty(path_list) then
         goto_node (path_list, changed_node);
      end if;
      changed_node_children := get_child_node (changed_node);
      if is_unique (node_name, changed_node_children) then
         alphabetical_insert
           (init(node_name, data, changed_node, set_null_cell),
            changed_node_children);
         set_child_node (changed_node_children, changed_node);
      else
         raise NOT_UNIQUE_ELEMENT;
      end if;
   end insert;


   procedure delete (path_to_node : in US_DLL.DoubleLinkedList_Pointer; current_node : in Tree_Node_Pointer) is
      path_list             : US_DLL.DoubleLinkedList_Pointer := path_to_node;
      node_name             : Unbounded_String;
      changed_node          : Tree_Node_Pointer := current_node;
      changed_node_children : TN_DLL.DoubleLinkedList_Pointer;
      found_element         : TN_DLL.DoubleLinkedList_Pointer;
   begin
      US_DLL.get_and_delete_last(path_list, node_name);
      if not US_DLL.is_empty(path_list) then
         goto_node (path_list, changed_node);
      end if;
      found_element := find_child (US_DLL.get_value (path_to_node), changed_node);
      if not TN_DLL.is_empty (found_element) then
         changed_node_children := get_child_node (changed_node);
         TN_DLL.delete (get_value (found_element), changed_node_children);
      else
         raise INEXISTANT_ELEMENT;
      end if;
   end delete;


   procedure display (current_node : in Tree_Node_Pointer; recusively : in Boolean := False; detailed : in Boolean := False; spaces : in Natural := 0) is
      
      current_node_children : TN_DLL.DoubleLinkedList_Pointer;
      nb_of_spaces          : Natural := spaces;
      
      procedure put_space (n : in Natural) is
      begin
         for i in 1 .. n loop
            Put (' ');
         end loop;
      end put_space;

      function folder_char (current_node : in Tree_Node_Pointer) return Character is
         folder_character      : Character;
      begin
         if isDirectory(get_metadata(current_node))
           and then get_node_name (current_node) /= To_Unbounded_String ("/")
         then
            folder_character := '/';
         else
            folder_character := ' ';
         end if;
         return folder_character;
      end folder_char;

      procedure put_info (current_node : in Tree_Node_Pointer) is
      begin
         Put(get_user_rights(get_metadata(current_node)));
         Put(' ');
         Put(get_size_on_disk(get_metadata(current_node)), width => 1);
         Put(' ');
         Put("'" & To_String(get_file_extension(get_metadata(current_node))) & "'");
         Put("  ");
      end put_info;

   begin
      if not is_empty (current_node) then
         Put_Line (print (current_node) & folder_char(current_node));
         current_node_children := get_child_node (current_node);
         nb_of_spaces          := nb_of_spaces + 4;
         while not is_empty (current_node_children) loop
            put_space (nb_of_spaces);
            if recusively then
               display (get_value (current_node_children), recusively, False, nb_of_spaces);
            else
               if detailed then
                  put_info(get_value (current_node_children));
               end if;
               Put_Line (print (get_value (current_node_children)) & folder_char(get_value (current_node_children)));
            end if;
            set_dll_cell
              (current_node_children, get_next (current_node_children));
         end loop;
      end if;
   end display;

end p_datastruct_tree;
