with Ada.Text_IO, Ada.Strings.Unbounded, p_metadata, p_datastruct_tree, p_commandfuncs;
use Ada.Text_IO, Ada.Strings.Unbounded, p_metadata, p_datastruct_tree, p_commandfuncs;

package body p_dms is

   function createDMS return Tree_Node_Pointer is
      data : Metadata;
   begin
      set_file_extension (To_Unbounded_String (""), data);
      set_user_rights ("drwx", data);
      set_size_on_disk (1, data);
      return init (To_Unbounded_String ("/"), data, null, TN_DLL.set_null_cell);
   end createDMS;


   procedure init (tree_root : in out Tree_Node_Pointer) is
      sc1                                      : Tree_Node_Pointer;
      sc2                                      : Tree_Node_Pointer;
      sc3                                      : Tree_Node_Pointer;
      scc1                                     : Tree_Node_Pointer;
      scc2                                     : Tree_Node_Pointer;
      datac1, datac2, datac3, datacc1, datacc2 : Metadata;
      child_list                               : TN_DLL.DoubleLinkedList_Pointer;
      children_list                            : TN_DLL.DoubleLinkedList_Pointer;
   begin
      set_file_extension (To_Unbounded_String (""), datac1);
      set_user_rights ("-rwx", datac1);
      set_size_on_disk (1, datac1);
      sc1 := init (To_Unbounded_String ("a"), datac1, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datac2);
      set_user_rights ("drwx", datac2);
      set_size_on_disk (1, datac2);
      sc2 := init (To_Unbounded_String ("d"), datac2, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datac3);
      set_user_rights ("drwx", datac3);
      set_size_on_disk (1, datac3);
      sc3 := init (To_Unbounded_String ("b"), datac3, tree_root, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datacc1);
      set_user_rights ("-rwx", datacc1);
      set_size_on_disk (1, datacc1);
      scc1 := init (To_Unbounded_String ("childb1"), datacc1, sc3, TN_DLL.set_null_cell);

      set_file_extension (To_Unbounded_String (""), datacc2);
      set_user_rights ("drwx", datacc2);
      set_size_on_disk (1, datacc2);
      scc2 := init (To_Unbounded_String ("childb2"), datacc2, sc3, TN_DLL.set_null_cell);

      alphabetical_insert (sc1, child_list);
      alphabetical_insert (sc2, child_list);
      alphabetical_insert (sc3, child_list);
      set_child_node (child_list, tree_root);

      alphabetical_insert (scc1, children_list);
      alphabetical_insert (scc2, children_list);
      set_child_node (children_list, sc3);
   end init;


   procedure display_path (path_dll : in US_DLL.DoubleLinkedList_Pointer) is
      tmp_dll       : US_DLL.DoubleLinkedList_Pointer := path_dll;
      absolute_path : Unbounded_String;
   begin
      -- Go to the start of the list
      US_DLL.goto_first_element (tmp_dll);
      while not US_DLL.is_empty (tmp_dll) loop
         -- If the current value or the previous value is not '/'
         if not (US_DLL.get_value (tmp_dll) = To_Unbounded_String ("/") or else US_DLL.get_value (US_DLL.get_previous (tmp_dll)) = To_Unbounded_String ("/")) then
            --Add the '/' character to the Unbounded String
            Append (absolute_path, '/');
         end if;
         --Add the current value to the Unbounded String
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


   procedure touch (path : in Unbounded_String; current_directory : in Tree_Node_Pointer) is
      changed_directory : Tree_Node_Pointer := current_directory;
      split_path     : US_DLL.DoubleLinkedList_Pointer;
      data              : Metadata;
      file_extension    : Unbounded_String;
      file_list         : US_DLL.DoubleLinkedList_Pointer; --List containing file name and file extension
   begin
      --If the path is empty
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      -- If the path starts with a '/', then go to the root directory
      elsif Element (path, 1) = '/' then
         goto_root (changed_directory);
      end if;
      --Split the input path using the '/' char
      split_path := split_command ('/', path);
      --This part adds the file's extension to its metadata
      --Split the file name using the '.' char
      file_list := split_command ('.', US_DLL.get_last (split_path));
      --If there is not file extension
      if US_DLL.length (file_list) = 1 then
         --Add an empty string to the metadata
         file_extension := To_Unbounded_String ("");
      else
         --Add the second element of the list to the metadata
         file_extension := US_DLL.get_last (file_list);
      end if;
      set_file_extension (file_extension, data);
      set_user_rights ("-rwx", data);
      set_size_on_disk (1, data);
      insert (split_path, data, changed_directory);
   end touch;


   procedure vim (path : in Unbounded_String; new_size : in Natural; current_directory : in Tree_Node_Pointer) is
      changed_directory : Tree_Node_Pointer := current_directory;
      file_name         : Unbounded_String;
      file              : TN_DLL.DoubleLinkedList_Pointer;
      file_node         : Tree_Node_Pointer;
      file_data         : Metadata;
   begin
      --If the path is empty
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      end if;
      --Change directory to the parent directory of the file
      cd_parent(path, file_name, changed_directory);
      file := find_child(file_name, changed_directory);
      file_node := TN_DLL.get_value(file);
      file_data := get_metadata(file_node);
      --If the file doesn't exist
      if TN_DLL.is_empty(file) then
         raise MISSING_NODE;
      --If the node is a directory and not a file
      elsif isDirectory(file_data) then
         raise ELEMENT_NOT_FILE;
      end if;
      set_size_on_disk(new_size, file_data);
      set_metadata(file_data, file_node);
   end vim;


   procedure mkdir (path : in Unbounded_String; current_directory : in Tree_Node_Pointer) is
      changed_directory : Tree_Node_Pointer := current_directory;
      split_path     : US_DLL.DoubleLinkedList_Pointer;
      data              : Metadata;
   begin
      --If the path is empty
      if path = To_Unbounded_String ("") then
         raise MISSING_ARGUMENTS;
      -- If the path starts with a '/', then go to the root directory
      elsif Element (path, 1) = '/' then
         goto_root (changed_directory);
      end if;
      set_file_extension (To_Unbounded_String (""), data);
      set_user_rights ("drwx", data);
      set_size_on_disk (1, data);
      --Split the input path using the '/' char
      split_path := split_command ('/', path);
      insert (split_path, data, changed_directory);
   end mkdir;


   procedure cd (path : in Unbounded_String; current_directory : in out Tree_Node_Pointer) is
      split_path : US_DLL.DoubleLinkedList_Pointer;
   begin
      --If the path is empty
      if path = To_Unbounded_String("") then
         -- Do nothing, doesn't matter for cd
         null;
      -- If the path starts with a '/', then go to the root directory
      elsif Element (path, 1) = '/' then
         goto_root (current_directory);
      end if;
      --Split the input path using the '/' char
      split_path := split_command ('/', path);
      goto_node (split_path, current_directory);
   end cd;
   
   procedure cd_parent (path : in Unbounded_String; name : out Unbounded_String; current_directory : in out Tree_Node_Pointer) is
      split_path : US_DLL.DoubleLinkedList_Pointer;
   begin
      --If the path is empty
      if path = To_Unbounded_String("") then
         -- Do nothing, doesn't matter for cd
         null;
      -- If the path starts with a '/', then go to the root directory
      elsif Element (path, 1) = '/' then
         goto_root (current_directory);
      end if;
      --Split the input path using the '/' char
      split_path := split_command ('/', path);
      US_DLL.get_and_delete_last(split_path, name);
      goto_node (split_path, current_directory);
   end cd_parent;


   procedure ls (current_directory : in Tree_Node_Pointer; path : in Unbounded_String := To_Unbounded_String (""); option : in Unbounded_String := To_Unbounded_String ("")) is
      changed_directory : Tree_Node_Pointer := current_directory;
      split_path     : US_DLL.DoubleLinkedList_Pointer;
      recursive : Boolean := False;
      details : Boolean := False;
   begin
      cd(path, changed_directory);
      if option = To_Unbounded_String("-r") then
         recursive := True;
      elsif option = To_Unbounded_String("-l") then
         details := True;
      --If options starts with '-' (so is really an unkown option)
      elsif option /= To_Unbounded_String("") and then Element(option, 1) = '-' then
         raise UNKNOWN_OPTION;
      end if;
      display(changed_directory, recursive, details);
   end ls;

end p_dms;
