with Ada.Text_IO, Ada.Strings.Unbounded, p_metadata, p_datastruct_tree, p_commandfuncs;
use Ada.Text_IO, Ada.Strings.Unbounded, p_metadata, p_datastruct_tree, p_commandfuncs;

package body p_dms is

   function createDMS return Tree_Node_Pointer is
      data : Metadata;
   begin
      set_file_extension (To_Unbounded_String (""), data);
      set_user_rights ("drwx", data);
      set_size_on_disk (1, data);
      return init
          (To_Unbounded_String ("/"), data, null, TN_DLL.set_null_cell);
   end createDMS;

   procedure init (tree_root : in out Tree_Node_Pointer) is
      sc1                                                : Tree_Node_Pointer;
      sc2                                                : Tree_Node_Pointer;
      sc3                                                : Tree_Node_Pointer;
      scc1                                               : Tree_Node_Pointer;
      scc2                                               : Tree_Node_Pointer;
      sccc1                                              : Tree_Node_Pointer;
      datac1, datac2, datac3, datacc1, datacc2, dataccc1 : Metadata;
      child_list : TN_DLL.DoubleLinkedList_Pointer;
      children_list : TN_DLL.DoubleLinkedList_Pointer;
      childrenn_list : TN_DLL.DoubleLinkedList_Pointer;
      before : TN_DLL.DoubleLinkedList_Pointer;
   begin

      set_file_extension (To_Unbounded_String (""), datac1);
      set_user_rights ("-rwx", datac1);
      set_size_on_disk (1, datac1);
      sc1 :=
        init
          (To_Unbounded_String ("a"), datac1, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datac2);
      set_user_rights ("drwx", datac2);
      set_size_on_disk (1, datac2);
      sc2 :=
        init
          (To_Unbounded_String ("d"), datac2, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datac3);
      set_user_rights ("drwx", datac3);
      set_size_on_disk (1, datac3);
      sc3 :=
        init
          (To_Unbounded_String ("b"), datac3, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datacc1);
      set_user_rights ("-rwx", datacc1);
      set_size_on_disk (1, datacc1);
      scc1 :=
        init
          (To_Unbounded_String ("childb1"), datacc1, sc3,
           TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datacc2);
      set_user_rights ("drwx", datacc2);
      set_size_on_disk (1, datacc2);
      scc2 :=
        init
          (To_Unbounded_String ("childb2"), datacc2, sc3,
           TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), dataccc1);
      set_user_rights ("drwx", dataccc1);
      set_size_on_disk (10, dataccc1);
      sccc1 :=
        init
          (To_Unbounded_String ("childbb2"), dataccc1, scc2,
           TN_DLL.set_null_cell);

      alphabetical_insert (sc1, child_list);

      set_child_node (child_list, tree_root);

      alphabetical_insert (sc2, child_list);

      alphabetical_insert (sc3, child_list);

      alphabetical_insert (scc1, children_list);

      alphabetical_insert (scc2, children_list);

      set_child_node (children_list, sc3);

      alphabetical_insert (sccc1, childrenn_list);

      set_child_node (childrenn_list, scc2);

   end init;

   procedure display_path (path_dll : in US_DLL.DoubleLinkedList_Pointer) is
      tmp_dll       : US_DLL.DoubleLinkedList_Pointer := path_dll;
      absolute_path : Unbounded_String;
   begin
      US_DLL.goto_first_element (tmp_dll);
      while not US_DLL.is_empty (tmp_dll) loop
         if not
           (US_DLL.get_value (tmp_dll) = To_Unbounded_String ("/")
            or else US_DLL.get_value (US_DLL.get_previous (tmp_dll)) =
              To_Unbounded_String ("/"))
         then
            Append (absolute_path, '/');
         end if;
         Append (absolute_path, US_DLL.get_value (tmp_dll));
         US_DLL.set_dll_cell (tmp_dll, US_DLL.get_next (tmp_dll));
      end loop;
      Put_Line (To_String (absolute_path));
   end display_path;

   procedure pwd (current_directory : in Tree_Node_Pointer) is
      tmp_pointer : Tree_Node_Pointer := current_directory;
      wd_path     : US_DLL.DoubleLinkedList_Pointer;
   begin
      while not is_empty (tmp_pointer) loop
         US_DLL.insert_at_start (get_node_name (tmp_pointer), wd_path);
         set_tree_node (tmp_pointer, get_parent_node (tmp_pointer));
      end loop;
      display_path (wd_path);
   end pwd;

   procedure touch
     (path : in Unbounded_String; current_directory : in Tree_Node_Pointer)
   is
      changed_directory : Tree_Node_Pointer := current_directory;
      splitted_path     : US_DLL.DoubleLinkedList_Pointer;
      data              : Metadata;
      file_extension    : Unbounded_String;
      file_list         : US_DLL
        .DoubleLinkedList_Pointer; --List containing file name and file extension
   begin
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      elsif Element (path, 1) = '/' then
         goto_root (changed_directory);
      end if;
      splitted_path := split_command ('/', path);
      file_list     := split_command ('.', US_DLL.get_last (splitted_path));
      if US_DLL.length (file_list) = 1 then
         file_extension := To_Unbounded_String ("");
      else
         file_extension := US_DLL.get_last (file_list);
      end if;
      set_file_extension (file_extension, data);
      set_user_rights ("-rwx", data);
      set_size_on_disk (1, data);
      insert (splitted_path, data, changed_directory);
   end touch;

   procedure vim
     (path : in Unbounded_String; new_size : in Natural; current_directory : in Tree_Node_Pointer)
   is
      changed_directory : Tree_Node_Pointer := current_directory;
      file_name : Unbounded_String;
      file : TN_DLL.DoubleLinkedList_Pointer;
      file_node : Tree_Node_Pointer;
      file_data : Metadata;
   begin
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      end if;
      cd_parent(path, file_name, changed_directory);
      file := find_child(file_name, changed_directory);
      file_node := TN_DLL.get_value(file);
      file_data := get_metadata(file_node);
      if TN_DLL.is_empty(file) then
         raise MISSING_NODE;
      elsif isDirectory(file_data) then
         raise ELEMENT_NOT_FILE;
      end if;
      set_size_on_disk(new_size, file_data);
      set_metadata(file_data, file_node);
   end vim;

   procedure mkdir
     (path : in Unbounded_String; current_directory : in Tree_Node_Pointer)
   is
      changed_directory : Tree_Node_Pointer := current_directory;
      splitted_path     : US_DLL.DoubleLinkedList_Pointer;
      data              : Metadata;
   begin
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      elsif Element (path, 1) = '/' then
         goto_root (changed_directory);
      end if;
      set_file_extension (To_Unbounded_String (""), data);
      set_user_rights ("drwx", data);
      set_size_on_disk (1, data);
      splitted_path := split_command ('/', path);
      insert (splitted_path, data, changed_directory);
   end mkdir;

   procedure cd
     (path : in Unbounded_String; current_directory : in out Tree_Node_Pointer)
   is
      splitted_path : US_DLL.DoubleLinkedList_Pointer;
   begin
      if path = To_Unbounded_String("") then
         null;
      elsif Element (path, 1) = '/' then
         goto_root (current_directory);
      end if;
      splitted_path := split_command ('/', path);
      goto_node (splitted_path, current_directory);
   end cd;
   
   procedure cd_parent
     (path : in Unbounded_String; name : out Unbounded_String; current_directory : in out Tree_Node_Pointer) is
      splitted_path : US_DLL.DoubleLinkedList_Pointer;
   begin
      if path = To_Unbounded_String("") then
         null;
      elsif Element (path, 1) = '/' then
         goto_root (current_directory);
      end if;
      splitted_path := split_command ('/', path);
      US_DLL.get_and_delete_last(splitted_path, name);
      goto_node (splitted_path, current_directory);
   end cd_parent;

   procedure ls
     (current_directory : in Tree_Node_Pointer;
      path              : in Unbounded_String := To_Unbounded_String ("");
      option            : in Unbounded_String := To_Unbounded_String (""))
   is
      changed_directory : Tree_Node_Pointer := current_directory;
      splitted_path     : US_DLL.DoubleLinkedList_Pointer;
      recursive : Boolean := False;
      details : Boolean := False;
   begin
      cd(path, changed_directory);
      if option = To_Unbounded_String("-r") then
         recursive := True;
      elsif option = To_Unbounded_String("-l") then
         details := True;
      elsif option /= To_Unbounded_String("") and then Element(option, 1) = '-' then
         raise UNKNOWN_OPTION;
      end if;
      display(changed_directory, recursive, details);
   end ls;

end p_dms;
