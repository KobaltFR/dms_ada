with Ada.Strings.unbounded, p_metadata, p_datastruct_tree;
use Ada.Strings.unbounded, p_metadata, p_datastruct_tree;

package body P_DMS is
   
   --function pathToNode(path : IN String) return Node;

   function createDMS return Tree_Node_Pointer is
      data : Metadata;
   begin
      set_file_extension(To_Unbounded_String(""), data);
      set_user_rights("drwx", data);
      set_size_on_disk(1, data);
      return init(To_Unbounded_String("/"), data, null, TN_DLL.set_null_cell);        
   end createDMS;

   procedure init(tree_root : IN OUT Tree_Node_Pointer) is
      sc1 : Tree_Node_Pointer;
      sc2 : Tree_Node_Pointer;
      sc3 : Tree_Node_Pointer;
      scc1 : Tree_Node_Pointer;
      scc2 : Tree_Node_Pointer;
      datac1, datac2, datac3, datacc1, datacc2 : Metadata;
      child_list : TN_DLL.DoubleLinkedList_Pointer;
      children_list : TN_DLL.DoubleLinkedList_Pointer;
      before : TN_DLL.DoubleLinkedList_Pointer;
   begin

      set_file_extension(To_Unbounded_String(""), datac1);
      set_user_rights("-rwx", datac1);
      set_size_on_disk(1, datac1);
      sc1 := init(To_Unbounded_String("a"), datac1, tree_root, TN_DLL.set_null_cell);

      set_file_extension(To_Unbounded_String(""), datac2);
      set_user_rights("drwx", datac2);
      set_size_on_disk(1, datac2);
      sc2 := init(To_Unbounded_String("d"), datac2, tree_root, TN_DLL.set_null_cell);

      set_file_extension(To_Unbounded_String(""), datac3);
      set_user_rights("drwx", datac3);
      set_size_on_disk(1, datac3);
      sc3 := init(To_Unbounded_String("b"), datac3, tree_root, TN_DLL.set_null_cell);

      set_file_extension(To_Unbounded_String(""), datacc1);
      set_user_rights("-rwx", datacc1);
      set_size_on_disk(1, datacc1);
      scc1 := init(To_Unbounded_String("childb1"), datacc1, sc3, TN_DLL.set_null_cell);

      set_file_extension(To_Unbounded_String(""), datacc2);
      set_user_rights("-rwx", datacc2);
      set_size_on_disk(1, datacc2);
      scc2 := init(To_Unbounded_String("childb2"), datacc2, sc3, TN_DLL.set_null_cell);

      alphabetical_insert(sc1, child_list);

      set_child_node(child_list, tree_root);

      alphabetical_insert(sc2, child_list);

      alphabetical_insert(sc3, child_list);

      alphabetical_insert(scc1, children_list);

      alphabetical_insert(scc2, children_list);

      set_child_node(children_list, sc3);

   end init;

   procedure pwd(current_directory : IN Tree_Node_Pointer) is
   begin
      null;
   end pwd;

   function touch(path : IN Unbounded_String) return Tree_Node_Pointer is
   begin
      return null;
   end touch;

   procedure vim(path : IN OUT Unbounded_String) is
   begin
      null;
   end vim;

   function mkdir(path : IN Unbounded_String) return Tree_Node_Pointer is
   begin
      return null;
   end mkdir;

   procedure cd(path : IN Unbounded_String) is
   begin
      null;
   end cd;

   procedure ls(path : IN Unbounded_String) is
   begin
      null;
   end ls;
   
end P_DMS;
