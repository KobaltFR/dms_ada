with Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree, p_dms;
use Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree, p_dms;

procedure main_test_tree is

   tree : Tree_Node_Pointer;

begin

   tree := createDMS;

   init(tree);

   p_datastruct_tree.display(tree);

end main_test_tree;
