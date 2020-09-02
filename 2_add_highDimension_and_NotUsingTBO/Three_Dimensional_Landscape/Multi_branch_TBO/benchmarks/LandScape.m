function [x, z, step, min_of_z, x_of_min_of_z, y_of_min_of_z, w_of_min_of_z] = LandScape (landScapeCode)
    switch landScapeCode
        case 1
            step = 1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            w = y;
            z = zeros(length(x),length(x),length(x));
            [X,Y,W]=meshgrid(x,y,w);
            [row,col,d3]=size(X);
%             cd('./benchmarks');
            for l=1:col
                for h=1:row
                    for m=1:d3
                        z(h,l,m)=Sphere([X(h,l,m),Y(h,l,m),W(h,l,m)]);
                        if h == 1 && l == 1 && m == 1
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        elseif z(h,l,m) < min_of_z
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        end
                    end
                end
            end

%             step = 1;
%             x_min = -100;
%             x_max = 100;
%             x = x_min:step:x_max;
%             y = x;
%             w = y;
%             z = zeros(length(x),length(x),length(x));
%             for i = 1:length(x)
%                 for j = 1:length(y)
%                     for k = 1:length(w)
%                         z(i,j) = (x(i)^2) + (y(j)^2) + (w(k)^2);
%                         if i == 1 && j == 1 && k == 1
%                             min_of_z = z(i,j,k);
%                             x_of_min_of_z = x(i);
%                             y_of_min_of_z = y(j);
%                             w_of_min_of_z = w(k);
%                         elseif z(i,j) < min_of_z
%                             min_of_z = z(i,j,k);
%                             x_of_min_of_z = x(i);
%                             y_of_min_of_z = y(j);
%                             w_of_min_of_z = w(k);
%                         end
%                     end
%                 end
%             end
        case 2
            step = 1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            w = y;
            z = zeros(length(x),length(x),length(x));
            [X,Y,W]=meshgrid(x,y,w);
            [row,col,d3]=size(X);
%             cd('./benchmarks');
            for l=1:col
                for h=1:row
                    for m=1:d3
                        z(h,l,m)=Griewank([X(h,l,m),Y(h,l,m),W(h,l,m)]);
                        if h == 1 && l == 1 && m == 1
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        elseif z(h,l,m) < min_of_z
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        end
                    end
                end
            end
%             cd('..');
        case 3
            step = 1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            w = y;
            z = zeros(length(x),length(x),length(x));
            [X,Y,W]=meshgrid(x,y,w);
            [row,col,d3]=size(X);
%             cd('./benchmarks');
            for l=1:col
                for h=1:row
                    for m=1:d3
                        z(h,l,m)=Schaffer([X(h,l,m),Y(h,l,m),W(h,l,m)]);
                        if h == 1 && l == 1 && m == 1
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        elseif z(h,l,m) < min_of_z
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        end
                    end
                end
            end
%             cd('..');
        case 4
            step = 1;
            x_min = -100;
            x_max = 100;
            x = x_min:step:x_max;
            y = x;
            w = y;
            z = zeros(length(x),length(x),length(x));
            [X,Y,W]=meshgrid(x,y,w);
            [row,col,d3]=size(X);
%             cd('./benchmarks');
            for l=1:col
                for h=1:row
                    for m=1:d3
                        z(h,l,m)=Schwefel([X(h,l,m),Y(h,l,m),W(h,l,m)]);
                        if h == 1 && l == 1 && m == 1
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        elseif z(h,l,m) < min_of_z
                            min_of_z = z(h,l,m);
                            x_of_min_of_z = x(h);
                            y_of_min_of_z = y(l);
                            w_of_min_of_z = w(m);
                        end
                    end
                end
            end
        otherwise
            error('Not valid landScapeCode!');
    end
end