with Ada.Text_IO;                   use Ada.Text_IO;
with mergefunc;                      use mergefunc;

procedure Mrgsort is
   x: numlist(1 .. 10000); -- Max Buffer
   n: integer := 0;
   p: Node_Ptr;
begin

   -- Read data
   readints(x,n);

   --  If data is read successfully
   if n>0 then

      -- Build LinkedList
      p := buildlist(x,n);   --  Put_Line(Integer'Image(p.data));

      -- Unsorted
      printlist(p);

      -- MergeSort
      mergesort(p);

      --  Put_Line(Integer'Image(p.data));
      --  Put_Line(Integer'Image(p.next.data));
      --  Put_Line(Integer'Image(p.next.next.data));
      --  Put_Line(Integer'Image(p.next.next.data));

      --  Wrtie to file
      printlist(p);
   end if;
end Mrgsort;
