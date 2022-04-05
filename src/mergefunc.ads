package mergefunc is

   type numlist is array (integer range <>) of integer;

   type Node;
   type Node_Ptr is access Node;
   type Node is record
      data: Integer;
      next: Node_Ptr;
   end record;



   -- Functions header
   procedure readints(x: in out numlist; n: in out integer);
   procedure printlist(p: in out Node_Ptr);
   function buildlist (x: in out numlist; n: in out integer) return Node_Ptr;
   procedure divide(p: in out Node_Ptr; q: in out Node_Ptr);
   procedure mergesort(p: in out Node_Ptr);
   function merge(p: in out Node_Ptr; q: in out Node_Ptr) return Node_Ptr ;

end mergefunc;
