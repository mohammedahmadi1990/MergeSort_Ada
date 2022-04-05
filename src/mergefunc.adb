with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;                   use Ada.Text_IO;
with Ada.Exceptions;                use Ada.Exceptions;
with Ada.Text_IO.Text_Streams;      use Ada.Text_IO.Text_Streams;
with Ada.Task_Identification;       use Ada.Task_Identification;
with Ada.Text_IO, Ada.Strings.Unbounded,Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Strings.Unbounded,Ada.Integer_Text_IO;

package body mergefunc is

   userFileName : Unbounded_String;


   procedure readints(x: in out numlist; n: in out integer) is
      File : File_Type;
      tempInt : Integer := 0;
      i : Natural := 1;
   begin

      --  Read user input (File name)
      Put_Line("Name of file to be sorted >");
      Get_Line(userFileName);

      begin
         -- Open file
         Open (File => File,
               Mode => In_File,
               Name => To_String(userFileName));

         -- Read integers
         --  Get (File,tempInt);
         while not End_Of_File (File) loop
            Get (File,tempInt);
            n := n + 1;
            x(n) := tempInt;
         end loop;
      exception
         when others =>
            Put_Line ("Sorry, file does not exist.");
            Abort_Task (Current_Task);
      end;
   end readints;

   procedure printlist(p: in out Node_Ptr) is
      F: File_Type;
      File_Name : String := "sortedA.txt";
      lineString : Unbounded_String;
      pt : Node_Ptr;
   begin

      Create (F, Out_File, File_Name);

      -- writing sorted integeres
      pt := p;
      while pt /= null loop
         lineString := (lineString & Integer'Image(pt.data));
         Put_Line(F,Ada.Strings.Unbounded.To_String(lineString));
         lineString := Ada.Strings.Unbounded.Null_Unbounded_String;
         pt := pt.next;
      end loop;
      Close (F);
   end printlist;

   procedure mergesort(p: in out Node_Ptr) is
      q: Node_Ptr;
   begin
      if p /= null then
         if p.next /= null then
            divide(p,q);
            mergesort(p);
            mergesort(q);
            p := merge(p,q);
            --  Put_Line("p: " & Integer'Image(p.data));
            --  Put_Line("q: " & Integer'Image(p.next.data));
         end if;
      end if;
   end mergesort;

   procedure divide(p: in out Node_Ptr; q: in out Node_Ptr) is
      r: Node_Ptr;
   begin
      q := p;
      r := p.next;
      r := r.next;
      while r /= null loop
         r := r.next;
         q := q.next;
         if r/= null then
            r := r.next;
         end if;
      end loop;
      r := q.next;
      q.next := null;
      q := r;
   end divide;


   function merge(p: in out Node_Ptr; q: in out Node_Ptr) return Node_Ptr is
      r :  Node_Ptr;
   begin
      if p = null or q = null then
         put("merge called with empty list");

         if p.data <= q.data then
            r := p;
            p := p.next;
         else
            r := q;
            q := q.next;
         end if;
         return r;
      end if;

      --  merge := r;
      while p /= null and q /= null loop
         if p.data <= q.data then
            Put_Line("r: " & Integer'Image(r.data));
            Put_Line("p: " & Integer'Image(p.data));
            Put_Line("q: " & Integer'Image(q.data));

            r.next := p;
            r := p;
            p := p.next;
         else
            r.next := q;
            r := q;
            q := q.next;
         end if;
      end loop;

      if p = null then
         r.next := q;
      else
         r.next := p;
      end if;

      return r;
   end merge;




   function buildlist (x: in out numlist; n: in out integer) return Node_Ptr is
      p: Node_Ptr;
      list: Node_Ptr;
   begin
      list := new Node;
      for i in 1 .. n loop
         p := new Node;
         p.data := x(i);
         p.next := list;
         list := p;
      end loop;

      return list;
   end buildlist;


end mergefunc;
