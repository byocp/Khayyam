namespace VisionSensor {
    partial class VisionSensorScreen {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            this.components = new System.ComponentModel.Container();
            this.g_per_L = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.stopBtn = new System.Windows.Forms.Button();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.great3 = new System.Windows.Forms.TextBox();
            this.great2 = new System.Windows.Forms.TextBox();
            this.great1 = new System.Windows.Forms.TextBox();
            this.exit_btn = new System.Windows.Forms.Button();
            this.memUsed = new System.Windows.Forms.TextBox();
            this.memAvailable = new System.Windows.Forms.TextBox();
            this.particles_per_L = new System.Windows.Forms.TextBox();
            this.Pic_num = new System.Windows.Forms.TextBox();
            this.Return_KexC = new System.Windows.Forms.Button();
            this.Start_btn = new System.Windows.Forms.Button();
            this.particles = new System.Windows.Forms.TextBox();
            this.proc_img = new System.Windows.Forms.PictureBox();
            this.raw_img = new System.Windows.Forms.PictureBox();
            this.Scroll_pics = new System.Windows.Forms.HScrollBar();
            this.RefreshMatlab = new System.Windows.Forms.Timer(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.proc_img)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.raw_img)).BeginInit();
            this.SuspendLayout();
            // 
            // g_per_L
            // 
            this.g_per_L.Location = new System.Drawing.Point(694, 331);
            this.g_per_L.Name = "g_per_L";
            this.g_per_L.Size = new System.Drawing.Size(74, 20);
            this.g_per_L.TabIndex = 74;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(662, 333);
            this.label9.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(24, 13);
            this.label9.TabIndex = 73;
            this.label9.Text = "g/L";
            // 
            // stopBtn
            // 
            this.stopBtn.BackColor = System.Drawing.SystemColors.Control;
            this.stopBtn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.stopBtn.Location = new System.Drawing.Point(337, 379);
            this.stopBtn.Name = "stopBtn";
            this.stopBtn.Size = new System.Drawing.Size(93, 36);
            this.stopBtn.TabIndex = 72;
            this.stopBtn.Text = "Stop";
            this.stopBtn.UseVisualStyleBackColor = false;
            this.stopBtn.Click += new System.EventHandler(this.stopBtn_Click);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(17, 285);
            this.label8.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(47, 13);
            this.label8.TabIndex = 71;
            this.label8.Text = "Picture#";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(627, 304);
            this.label7.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(58, 13);
            this.label7.TabIndex = 70;
            this.label7.Text = "Particles/L";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(596, 280);
            this.label6.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(94, 13);
            this.label6.TabIndex = 69;
            this.label6.Text = "TotalParticleCount";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(627, 395);
            this.label5.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(72, 13);
            this.label5.TabIndex = 68;
            this.label5.Text = "Memory Used";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(588, 370);
            this.label4.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(111, 13);
            this.label4.TabIndex = 67;
            this.label4.Text = "TotalMemoryAvailable";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(17, 422);
            this.label3.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(93, 13);
            this.label3.TabIndex = 66;
            this.label3.Text = "Particles > 1.0 mm";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(17, 389);
            this.label2.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(93, 13);
            this.label2.TabIndex = 65;
            this.label2.Text = "Particles > 0.4 mm";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(17, 358);
            this.label1.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 13);
            this.label1.TabIndex = 64;
            this.label1.Text = "Particles > 0.1 mm";
            // 
            // great3
            // 
            this.great3.Location = new System.Drawing.Point(116, 419);
            this.great3.Name = "great3";
            this.great3.Size = new System.Drawing.Size(74, 20);
            this.great3.TabIndex = 63;
            // 
            // great2
            // 
            this.great2.Location = new System.Drawing.Point(116, 387);
            this.great2.Name = "great2";
            this.great2.Size = new System.Drawing.Size(74, 20);
            this.great2.TabIndex = 62;
            // 
            // great1
            // 
            this.great1.Location = new System.Drawing.Point(116, 355);
            this.great1.Name = "great1";
            this.great1.Size = new System.Drawing.Size(74, 20);
            this.great1.TabIndex = 61;
            // 
            // exit_btn
            // 
            this.exit_btn.BackColor = System.Drawing.SystemColors.Control;
            this.exit_btn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.exit_btn.Location = new System.Drawing.Point(484, 269);
            this.exit_btn.Name = "exit_btn";
            this.exit_btn.Size = new System.Drawing.Size(93, 36);
            this.exit_btn.TabIndex = 60;
            this.exit_btn.Text = "Exit";
            this.exit_btn.UseVisualStyleBackColor = false;
            this.exit_btn.Click += new System.EventHandler(this.exit_btn_Click_1);
            // 
            // memUsed
            // 
            this.memUsed.Location = new System.Drawing.Point(704, 392);
            this.memUsed.Name = "memUsed";
            this.memUsed.Size = new System.Drawing.Size(65, 20);
            this.memUsed.TabIndex = 58;
            // 
            // memAvailable
            // 
            this.memAvailable.Location = new System.Drawing.Point(704, 368);
            this.memAvailable.Name = "memAvailable";
            this.memAvailable.Size = new System.Drawing.Size(65, 20);
            this.memAvailable.TabIndex = 57;
            // 
            // particles_per_L
            // 
            this.particles_per_L.Location = new System.Drawing.Point(694, 301);
            this.particles_per_L.Name = "particles_per_L";
            this.particles_per_L.Size = new System.Drawing.Size(74, 20);
            this.particles_per_L.TabIndex = 56;
            // 
            // Pic_num
            // 
            this.Pic_num.Location = new System.Drawing.Point(76, 283);
            this.Pic_num.Name = "Pic_num";
            this.Pic_num.Size = new System.Drawing.Size(74, 20);
            this.Pic_num.TabIndex = 55;
            // 
            // Return_KexC
            // 
            this.Return_KexC.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.Return_KexC.Location = new System.Drawing.Point(284, 269);
            this.Return_KexC.Name = "Return_KexC";
            this.Return_KexC.Size = new System.Drawing.Size(177, 36);
            this.Return_KexC.TabIndex = 54;
            this.Return_KexC.Text = "Back to Kex-C";
            this.Return_KexC.UseVisualStyleBackColor = true;
            this.Return_KexC.Click += new System.EventHandler(this.Return_KexC_Click);
            // 
            // Start_btn
            // 
            this.Start_btn.BackColor = System.Drawing.SystemColors.Control;
            this.Start_btn.Font = new System.Drawing.Font("Segoe UI", 15.75F);
            this.Start_btn.Location = new System.Drawing.Point(170, 269);
            this.Start_btn.Name = "Start_btn";
            this.Start_btn.Size = new System.Drawing.Size(93, 36);
            this.Start_btn.TabIndex = 53;
            this.Start_btn.Text = "Start";
            this.Start_btn.UseVisualStyleBackColor = false;
            this.Start_btn.Click += new System.EventHandler(this.Start_btn_Click);
            // 
            // particles
            // 
            this.particles.Location = new System.Drawing.Point(694, 277);
            this.particles.Name = "particles";
            this.particles.Size = new System.Drawing.Size(74, 20);
            this.particles.TabIndex = 59;
            // 
            // proc_img
            // 
            this.proc_img.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.proc_img.Location = new System.Drawing.Point(398, 11);
            this.proc_img.Name = "proc_img";
            this.proc_img.Size = new System.Drawing.Size(370, 245);
            this.proc_img.TabIndex = 52;
            this.proc_img.TabStop = false;
            // 
            // raw_img
            // 
            this.raw_img.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.raw_img.Location = new System.Drawing.Point(10, 11);
            this.raw_img.Name = "raw_img";
            this.raw_img.Size = new System.Drawing.Size(369, 245);
            this.raw_img.TabIndex = 51;
            this.raw_img.TabStop = false;
            // 
            // Scroll_pics
            // 
            this.Scroll_pics.Location = new System.Drawing.Point(199, 323);
            this.Scroll_pics.Maximum = 10;
            this.Scroll_pics.Name = "Scroll_pics";
            this.Scroll_pics.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.Scroll_pics.Size = new System.Drawing.Size(409, 40);
            this.Scroll_pics.TabIndex = 50;
            // 
            // RefreshMatlab
            // 
            this.RefreshMatlab.Enabled = true;
            this.RefreshMatlab.Tick += new System.EventHandler(this.RefreshMatlab_Tick);
            // 
            // VisionSensorScreen
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(777, 449);
            this.Controls.Add(this.g_per_L);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.stopBtn);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.great3);
            this.Controls.Add(this.great2);
            this.Controls.Add(this.great1);
            this.Controls.Add(this.exit_btn);
            this.Controls.Add(this.memUsed);
            this.Controls.Add(this.memAvailable);
            this.Controls.Add(this.particles_per_L);
            this.Controls.Add(this.Pic_num);
            this.Controls.Add(this.Return_KexC);
            this.Controls.Add(this.Start_btn);
            this.Controls.Add(this.particles);
            this.Controls.Add(this.proc_img);
            this.Controls.Add(this.raw_img);
            this.Controls.Add(this.Scroll_pics);
            this.Margin = new System.Windows.Forms.Padding(2, 2, 2, 2);
            this.Name = "VisionSensorScreen";
            this.Text = "VisionSensorScreen";
            this.Load += new System.EventHandler(this.VisionSensorScreen_Load);
            ((System.ComponentModel.ISupportInitialize)(this.proc_img)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.raw_img)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox g_per_L;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button stopBtn;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox great3;
        private System.Windows.Forms.TextBox great2;
        private System.Windows.Forms.TextBox great1;
        private System.Windows.Forms.Button exit_btn;
        private System.Windows.Forms.TextBox memUsed;
        private System.Windows.Forms.TextBox memAvailable;
        private System.Windows.Forms.TextBox particles_per_L;
        private System.Windows.Forms.TextBox Pic_num;
        private System.Windows.Forms.Button Return_KexC;
        private System.Windows.Forms.Button Start_btn;
        private System.Windows.Forms.TextBox particles;
        private System.Windows.Forms.PictureBox proc_img;
        private System.Windows.Forms.PictureBox raw_img;
        private System.Windows.Forms.HScrollBar Scroll_pics;
        private System.Windows.Forms.Timer RefreshMatlab;
    }
}