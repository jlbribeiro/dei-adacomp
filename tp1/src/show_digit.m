%-------------------------------------------------------------
%    DEI - Computacao Adaptativa
%    Jorge Henriques
%-------------------------------------------------------------

function xx=show_digit(digit_size, X, Y, Z)

figure(1)
n=nargin;
nL=digit_size.height;
nC=digit_size.width;

clf
%[nL,nC]=size(X);
X=[reshape(X(:),nL,nC)];
[nL,nC]=size(X);

hold on
incx= 0.3;
incy=-0.03;
yini=1;
xini=0;
TAM=14;
axis([xini 6 0.7 1.05])

for i=1:nL
    for j=1:nC
        if (X(i,j)==0)
            plot(xini+j*incx,yini+i*incy,'sr','MarkerSize',TAM);
        else
            plot(xini+j*incx,yini+i*incy,'sk',xini+j*incx,yini+i*incy,'*','MarkerSize',TAM);
        end
    end
end

%=========================================
yini=1.0;
xini=2.0;
if n>2
    X=Y;
    %---------------------------------
    X=reshape(X,nL,nC);
    for i=1:nL
        for j=1:nC
            if (X(i,j)==0)
                plot(xini+j*incx,yini+i*incy,'sr','MarkerSize',TAM);
            else
                plot(xini+j*incx,yini+i*incy,'sk', 'MarkerSize',TAM);
                plot(xini+j*incx,yini+i*incy,'*', 'MarkerSize',TAM);
            end
        end
    end
end


%=========================================
yini=1.0;
xini=4.0;
if n>3
    X=Z;
    %---------------------------------
    X=reshape(X,nL,nC);
    for i=1:nL
        for j=1:nC
            if (X(i,j)==0)
                plot(xini+j*incx,yini+i*incy,'sr','MarkerSize',TAM);
            else
                plot(xini+j*incx,yini+i*incy,'sk', 'MarkerSize',TAM);
                plot(xini+j*incx,yini+i*incy,'*', 'MarkerSize',TAM) ;
            end
        end
    end
end
