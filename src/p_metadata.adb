with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package body p_metadata is

   function get_file_extension(data : IN Metadata) return Unbounded_String is
   begin
      return data.fileExtension;
   end get_file_extension;

   procedure set_file_extension(extension : IN Unbounded_String; data : IN OUT Metadata) is
   begin
      data.fileExtension := extension;
   end set_file_extension;

   function get_user_rights(data : IN Metadata) return String is
   begin
      return data.userRights;
   end get_user_rights;

   procedure set_user_rights(rights : IN String; data : IN OUT Metadata) is
   begin
      data.userRights := rights;
   end set_user_rights;

   function get_size_on_disk(data : IN Metadata) return Integer is
   begin
      return data.sizeOnDisk;
   end get_size_on_disk;

   procedure set_size_on_disk(size : IN Natural; data : IN OUT Metadata) is
   begin
      data.sizeOnDisk := size;
   end set_size_on_disk;

   function isDirectory(data : IN Metadata) return Boolean is
   begin
      return data.userRights(1) = 'd';
   end isDirectory;

end p_metadata;
