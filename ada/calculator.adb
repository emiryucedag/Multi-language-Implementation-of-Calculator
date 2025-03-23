with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Float_Text_IO;   use Ada.Float_Text_IO;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Ada.Text_IO.Unbounded_IO;
with Ada.Numerics.Elementary_Functions;

procedure Calculator is

   type String_Access is access String;

   function Power (Base, Exponent : Float) return Float is
   begin
      return Ada.Numerics.Elementary_Functions."**"(Base, Exponent);
   end Power;

   function Evaluate(Expression : String) return Float;

   function Evaluate(Expression : String) return Float is
      Pos : Integer := 1;
      Len : constant Integer := Expression'Length;

      function Get_Token return Character is
         Ch : Character;
      begin
         while Pos <= Len and then Expression(Pos) = ' ' loop
            Pos := Pos + 1;
         end loop;
         if Pos > Len then
            return ASCII.NUL;
         else
            Ch := Expression(Pos);
            Pos := Pos + 1;
            return Ch;
         end if;
      end Get_Token;

      function Parse_Number return Float is
         Start : Integer := Pos;
         Stop  : Integer := Pos;
         Num_Str : String(1 .. Len);
         Num_Len : Integer := 0;
      begin
         while Stop <= Len and then (Expression(Stop) in '0' .. '9' or Expression(Stop) = '.') loop
            Num_Len := Num_Len + 1;
            Num_Str(Num_Len) := Expression(Stop);
            Stop := Stop + 1;
         end loop;
         Pos := Stop;
         declare
            Num : Float;
         begin
            Num := Float'Value(Num_Str(1 .. Num_Len));
            return Num;
         end;
      end Parse_Number;

      function Factor return Float;
      function Term return Float;
      function Expr return Float;

      function Factor return Float is
         Ch : Character := Get_Token;
         Val : Float;
      begin
         if Ch = '(' then
            Val := Expr;
            if Get_Token /= ')' then
               raise Constraint_Error with "Missing closing parenthesis.";
            end if;
            return Val;
         elsif Ch in '0' .. '9' then
            Pos := Pos - 1;
            return Parse_Number;
         else
            raise Constraint_Error with "Unexpected character: '" & Ch & "'";
         end if;
      end Factor;

      function Term return Float is
         Left : Float := Factor;
         Ch   : Character;
      begin
         loop
            exit when Pos > Len;
            Ch := Expression(Pos);
            if Ch = '*' then
               Pos := Pos + 1;
               Left := Left * Factor;
            elsif Ch = '/' then
               Pos := Pos + 1;
               declare
                  Right : Float := Factor;
               begin
                  if Right = 0.0 then
                     raise Constraint_Error with "Division by zero.";
                  end if;
                  Left := Left / Right;
               end;
            elsif Ch = '^' then
               Pos := Pos + 1;
               Left := Power(Left, Factor);
            else
               exit;
            end if;
         end loop;
         return Left;
      end Term;

      function Expr return Float is
         Left : Float := Term;
         Ch   : Character;
      begin
         loop
            exit when Pos > Len;
            Ch := Expression(Pos);
            if Ch = '+' then
               Pos := Pos + 1;
               Left := Left + Term;
            elsif Ch = '-' then
               Pos := Pos + 1;
               Left := Left - Term;
            else
               exit;
            end if;
         end loop;
         return Left;
      end Expr;

   begin
      return Expr;
   end Evaluate;

   Line : String(1 .. 200);
   Len  : Natural;

begin
   Put_Line("Enter expressions to evaluate (Ctrl+C to exit):");
   loop
      Put("> ");
      Get_Line(Line, Len);
      declare
         Expr : constant String := Line(1 .. Len);
         Result : Float := Evaluate(Expr);
      begin
         Put("= ");
         Put(Result, Fore => 1, Aft => 4, Exp => 0);
         New_Line;
      exception
         when Constraint_Error =>
            Put_Line("Syntax error or division by zero.");
         when others =>
            Put_Line("Unknown error.");
      end;
   end loop;
end Calculator;
