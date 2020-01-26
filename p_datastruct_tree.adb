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

   --PRECOND : dll is initialized and contains elements
   --Returns null if you need to add at the start, or the privous element of the location you need to insert at.
   function alphabetical_insert_after(name : IN Unbounded_String; dll : IN TN_DLL.DoubleLinkedList_Pointer) return TN_DLL.DoubleLinkedList_Pointer is
      tmp : TN_DLL.DoubleLinkedList_Pointer := dll;
      spot : TN_DLL.DoubleLinkedList_Pointer;
      found_spot : Boolean := False;
   begin

      while (not is_empty(tmp)) and then (not found_spot) loop
         if get_node_name(get_value(tmp)) > name then
            spot := init;
            found_spot := True;
         elsif get_node_name(get_value(tmp)) < name then
            if is_empty(get_next(tmp)) then
               set_dll_cell(out_cell => spot, in_cell => get_previous(tmp));
               found_spot := True;
            else
               set_dll_cell(tmp, get_next(tmp));
            end if;
         end if;
      end loop;

      return spot;
   end alphabetical_insert_after;

   function init return Tree_Node_Pointer is
      initalTree : Tree_Node_Pointer;
      sc1 : Tree_Node_Pointer;
      sc2 : Tree_Node_Pointer;
      sc3 : Tree_Node_Pointer;
      data, datac1, datac2, datac3 : Metadata;
      child_list : TN_DLL.DoubleLinkedList_Pointer := init;
      before : TN_DLL.DoubleLinkedList_Pointer := init;
   begin

      set_file_extension(To_Unbounded_String(""), data);
      set_user_rights("drwx", data);
      set_size_on_disk(1, data);
      initalTree := new Tree_Node'(To_Unbounded_String("\"), data, null, child_list);

      set_file_extension(To_Unbounded_String(""), datac1);
      set_user_rights("drwx", datac1);
      set_size_on_disk(1, datac1);
      sc1 := new Tree_Node'(To_Unbounded_String("a"), datac1, initalTree, TN_DLL.init);

      set_file_extension(To_Unbounded_String(""), datac2);
      set_user_rights("drwx", datac2);
      set_size_on_disk(1, datac2);
      sc2 := new Tree_Node'(To_Unbounded_String("b"), datac2, initalTree, TN_DLL.init);

      set_file_extension(To_Unbounded_String(""), datac3);
      set_user_rights("drwx", datac3);
      set_size_on_disk(1, datac3);
      sc3 := new Tree_Node'(To_Unbounded_String("d"), datac1, initalTree, TN_DLL.init);

      before := alphabetical_insert_after(get_node_name(sc1), get_child_node(initalTree));
      if not is_empty(before) then
         insert_after(sc1, TN_DLL.get_value(before), child_list);
      else
         insert_at_start(sc1, child_list);
         TN_DLL.display(get_child_node(initalTree));

      end if;

      before := alphabetical_insert_after(get_node_name(sc2), get_child_node(initalTree));
      if not is_empty(before) then
         insert_after(sc2, TN_DLL.get_value(before), child_list);
      else
         insert_at_start(sc2, child_list);
      end if;

      before := alphabetical_insert_after(get_node_name(sc3), get_child_node(initalTree));
      if not is_empty(before) then
         insert_after(sc3, TN_DLL.get_value(before), child_list);
      else
         insert_at_start(sc1, child_list);
      end if;

      Put_Line(print(initalTree));

      TN_DLL.display(get_child_node(initalTree));

      return initalTree;
   end init;

   function is_empty(node : IN Tree_Node_Pointer) return Boolean is
   begin
      return node = null;
   end is_empty;

   procedure insert(path_to_node : IN Unbounded_String; data : IN Metadata; current_node : IN OUT Tree_Node_Pointer) is
      path_list : US_DLL.DoubleLinkedList_Pointer;
   begin
      path_list := split_command('\', path_to_node);
      if US_DLL.length(path_list) = 1 then
         null;
      end if;
   end insert;

   function get_node(path_to_node : IN Unbounded_String; current_node : IN Tree_Node_Pointer) return Tree_Node_Pointer is
   begin
      return null;
   end get_node;

   procedure delete(path_to_node : IN Unbounded_String; current_node : IN OUT Tree_Node_Pointer) is
   begin
      null;
   end delete;

   procedure display(current_node : IN Tree_Node_Pointer; space: IN Integer := 0) is
   begin
      null;
   end display;

end p_datastruct_tree;
