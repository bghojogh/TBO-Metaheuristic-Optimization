clc
clear all
close all

%% F1:
binary = 9.0219 + 0.0169 + 0.3430 + 2.1934 + 0.0200 + 0.1026;
multi = 3.6248 + 0 + 0.1372 + 2.2155 + 0 + 0.1030;
adaptive = 5.4976 + 0.0040 + 0.0900 + 1.9656 + 0.0057 + 0.0720;
F(1,1) = 100 * binary / (binary + multi + adaptive);
F(1,2) = 100 * multi / (binary + multi + adaptive);
F(1,3) = 100 * adaptive / (binary + multi + adaptive);

%% F2:
binary = 13.2728 + 2.3632 + 8.9287 + 5.0582 + 1.3267 + 6.0298;
multi = 5.4592 + 0.4402 + 3.6310 + 6.9459 + 0.2193 + 3.0586;
adaptive = 10.4106 + 1.6897 + 6.3533 + 5.7534 + 1.5102 + 3.9325;
F(2,1) = 100 * binary / (binary + multi + adaptive);
F(2,2) = 100 * multi / (binary + multi + adaptive);
F(2,3) = 100 * adaptive / (binary + multi + adaptive);

%% F3:
binary = 8.3610 + 0.1906 + 1.5908 + 4.1186 + 0.1626 + 0.5851;
multi = 3.1959 + 0.0257 + 0.4747 + 5.9887 + 0.0040 + 0.8353;
adaptive = 3.5450 + 0.0859 + 0.2286 + 2.5128 + 0.1250 + 0.2609;
F(3,1) = 100 * binary / (binary + multi + adaptive);
F(3,2) = 100 * multi / (binary + multi + adaptive);
F(3,3) = 100 * adaptive / (binary + multi + adaptive);

%% F4:
binary = 536.0729 + 260.6400 + 147.5810 + 337.4942 + 144.8400 + 0.7545;
multi = 516.6231 + 231.6800 + 0.8139 + 360.7726 + 86.9200 + 1.0497;
adaptive = 445.9687 + 115.8800 + 0.7405 + 180.4240 + 28.9600 + 0.6833;
F(4,1) = 100 * binary / (binary + multi + adaptive);
F(4,2) = 100 * multi / (binary + multi + adaptive);
F(4,3) = 100 * adaptive / (binary + multi + adaptive);

%% bar:
bar(F, 'grouped');
ylim([0 100]);
legend('Binary TBO', 'Multi-branch TBO', 'Adaptive TBO');
xlabel('Benchmarks');
ylabel('Average percent error');
set(gca, 'XTickLabel',{'F1','F2','F3','F4'});
