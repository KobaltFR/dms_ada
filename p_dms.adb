with Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;
use Ada.Strings.unbounded, Ada.Text_IO.Unbounded_IO, p_datastruct_tree;

package body P_DMS is
   
   --function pathToNode(path : IN String) return Node;

   function createDMS return NodePtr is
     ptr : NodePtr;
   begin
       ptr := new Node'(To_Unbounded_String("/"),To_Unbounded_String(""),"drwx",0,null,null,null);
       return ptr;        
   end createDMS;

   procedure init(rootPtr : IN OUT NodePtr) is
      etcPtr, binPtr, sharePtr, apachePtr, optPtr, hostsPtr, blblPtr, cdPtr, pwdPtr, guiPtr : NodePtr;
   begin
       guiPtr := New Node'(To_Unbounded_String("gui"),To_Unbounded_String("dll"),"-rwx",0,null,null,null);
       optPtr := New Node'(To_Unbounded_String("opt"),To_Unbounded_String(""),"drwx",0,null,null,null);
       sharePtr := New Node'(To_Unbounded_String("share"),To_Unbounded_String(""),"drwx",0,null,null,null);
   end init;

   procedure pwd(ptr : IN NodePtr) is
   begin
      null;
   end pwd;

   function touch(path : IN String) return NodePtr is
   begin
      return null;
   end touch;

   procedure vim(path : IN OUT String) is
   begin
      null;
   end vim;

   function mkdir(path : IN String) return NodePtr is
   begin
      return null;
   end mkdir;

   procedure cd(path : IN String) is
   begin
      null;
   end cd;

   procedure ls(path : IN String) is
   begin
      null;
   end ls;
   
end P_DMS;
