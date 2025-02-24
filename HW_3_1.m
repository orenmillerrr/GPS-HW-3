clear;clc;close all 

sims = 1000;

var_a = 2;
var_b = 2;

for i = 1 : 1000
    a = sqrt(var_a)*randn(1);
    b = sqrt(var_b)*randn(1);

    y(i) = 3*a + 4*b;
    y_minus(i) = 3*a - 4*b;
   
end

sgtitle("Question 1")
subplot(1,2,1)
histogram(y)
title("y = 3a + 4b")
xlabel('y Value')
ylabel('Count')
subplot(1,2,2)
histogram(y_minus)
title("y = 3a - 4b")
xlabel('y Value')
ylabel('Count')