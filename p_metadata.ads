with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package p_metadata is

   type Metadata is private;

   function get_file_extension(data : IN Metadata) return Unbounded_String;
   procedure set_file_extension(extension : IN Unbounded_String; data : IN OUT Metadata);

   function get_user_rights(data : IN Metadata) return String;
   procedure set_user_rights(rights : IN String; data : IN OUT Metadata);

   function get_size_on_disk(data : IN Metadata) return Integer;
   procedure set_size_on_disk(size : IN Integer; data : IN OUT Metadata);

private

   MAX_RIGHTS_LENGTH : Positive := 4;

   type Metadata is record
      fileExtension : Unbounded_String;
      userRights : String(1..MAX_RIGHTS_LENGTH);
      sizeOnDisk : Integer;
   end record;

end p_metadata;
