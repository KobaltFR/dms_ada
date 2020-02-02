with Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree, p_commandfuncs, P_DMS, p_metadata;
use Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree, p_commandfuncs, P_DMS, p_metadata;

procedure main_test_tree is

   tree : Tree_Node_Pointer;

   str : Unbounded_String;

begin

   tree := createDMS;

   init (tree);

   mkdir (To_Unbounded_String("/b/childb2/childbb1"), tree);
   mkdir (To_Unbounded_String("c"), tree);
   touch (To_Unbounded_String("b/childb2/childbb1/tree.adb"), tree);
   touch (To_Unbounded_String("/b/childb2/README.md"), tree);
   cd (To_Unbounded_String(""), tree);

   Put_Line ("Current dir : " & To_String (get_node_name (tree)));

   ls (To_Unbounded_String("/b/childb2"), tree, To_Unbounded_String("-l"));

end main_test_tree;
