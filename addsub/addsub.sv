module addsub(A,B,add_sub,Result);

    input logic [15:0]A,B;
    input logic add_sub;
    output logic [15:0]Result;

    always_comb

    if (add_sub) Result=A+B;
    else Result=A-B;

endmodule
