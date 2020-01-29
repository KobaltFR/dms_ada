with Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree;
use Ada.Text_IO, Ada.Strings.Unbounded, p_datastruct_tree;

procedure main_test_tree is

   tree : Tree_Node_Pointer;

begin

   tree := p_datastruct_tree.init;

   p_datastruct_tree.display(tree);

end main_test_tree;
