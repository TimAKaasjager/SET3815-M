function Simulateblockstest(app)
step = -20;
if app.Image2.Position(2) < 10
    app.Image2.Position = [75 372 100 100];
end
app.Image2.Visible = 'on';
app.Image3.Visible = 'off';
app.Image4.Visible = 'off';
app.Image2.Position = app.Image2.Position + [0 step 0 0];

end